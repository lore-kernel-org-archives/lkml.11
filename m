Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6227FC25B08
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 04:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbiHWEon (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 00:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiHWEoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:44:39 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE34A52FEE
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:44:38 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b8-20020a170903228800b0016f2420ddedso8448557plh.19
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=lUCov81UkiL3yx2Zk6OCNHheGGSC+JEtAVpS5cfgjxg=;
        b=VQQRSuwFAryakFZN7o3XBnaC86NJb8BJN0kRwrV1UIIXqU6A4bnuxTOScxrfAYh32h
         AFsHq3EqIR/7SXFP72lFWxUyEZczBThvbRXWGVEegkJk2vJM6nV72YXBmf1+lxt/IGvP
         yXHwxpKfsThjjhWZzQI8//FWRXgDqOU4sUnkrhBRsXHHnzbZnB/tLEREshRyt8/D0K1I
         3K9o2H+mau3uY9LNULYduQ3LmFi8GnYNe9PwfLPaMjcivIR+H6Df56RSEu4sVvSlr/Gi
         lp3ApSG31oiReNNTdWxh1fI/2LArEf/6HjkzgcakX6PVq9Qzl1VXfuYHcq3FTJ+tRX8k
         k2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=lUCov81UkiL3yx2Zk6OCNHheGGSC+JEtAVpS5cfgjxg=;
        b=5wL0CSOa9jGfB0i8S8JU6N6PZYVey2gnQeEtB7+atn1iBZcSi+LaMLwzx7wKCKj0PP
         neZXLX1P1JVh6Qo93KF711CofPZuEdWteaeayjKM6nQ0MOLMBeTBMI8lHX46F5tuS5pE
         7l+EjBbyRAtCsEitUmZj7VLJsJe1IoizPpRuID+kjfMb4IntE0jN8FeaaEBY64uGxM5P
         X6ko9R1GNw26jhbEpBgdhF1qd5iJjaxg8I4RKg6oFJHtkcVv8WnFF6SOrVeLWGgOCHV8
         6U1km0dqdsAtH/hukQHcP3KYtWQ4y6Y1EfkOK8NZpas1SS4tjKdYhAfZyBWMTFP7awZB
         Y7Vw==
X-Gm-Message-State: ACgBeo28IKKitQWpwxEEt98IBTh4zLfQW5oGg72WJwqELzOzvtTavtLx
        E7vNKAIxHJy88x6uIcN+Wqv2hzIpCWoo
X-Google-Smtp-Source: AA6agR7/lhkKKG625n3CGJmIMAJbr4gWG/sOy8pBi23P52QZoLOqIdbElGQtnBsHGCnel8Lni/KVxBZY9r4L
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90b:a14:b0:1fa:bc6e:e5e8 with SMTP id
 gg20-20020a17090b0a1400b001fabc6ee5e8mr125775pjb.1.1661229877885; Mon, 22 Aug
 2022 21:44:37 -0700 (PDT)
Date:   Mon, 22 Aug 2022 21:44:33 -0700
Message-Id: <20220823044434.3402413-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [kernel PATCH v2 0/1] Bluetooth: hci_sync: hold hdev->lock when
 cleanup hci_conn
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hold hdev->lock for hci_conn_failed. There are possible race conditions
which may cause kernel crash.

Changes in v2:
- Update commit message

Changes in v1:
- Hold hdev->lock for hci_conn_failed

Zhengping Jiang (1):
  Bluetooth: hci_sync: hold hdev->lock when cleanup hci_conn

 net/bluetooth/hci_sync.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.37.1.595.g718a3a8f04-goog

