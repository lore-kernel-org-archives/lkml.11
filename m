Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C3DC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 18:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiGVSpF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 14:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiGVSpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:45:02 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAE98C3FD
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:45:01 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q12-20020a632a0c000000b00419b66851e8so2683889pgq.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3qqLBm0xV4mGiZiGED2yL3VCWOwhq7//Y+5w9DIVSJI=;
        b=io+OBpMGgliqn5b9xs9McUXAdcOR15jmgf3SbyuZYnVDFS8ZIpX0LqD7igItbqorGq
         +3/WJ6Bl3ItdBxn9CJ2961CIVCXupwiGrZ8IOW+VaAyJQl5wXeiEnjgxX2gSljfnrA5+
         5F0WWja4vsTmzVE0QIDeTs7zkbUd8phCHLQLc4DlTMrlxcMYu6GLKqJWAvwAzHiVWABT
         R7gPl+0yUBrtJMi13Wj/8oUGZ1N+QPfSDuTO8kL+34AskPfU8Bl6zmeybYfuhaRaaSJj
         zn9Vz023Y5Y2w/DpIpwdBqQz4JgtZ5QWOO3/URJD2gQviYmlFP5+ypSYDhtPMr93y9qs
         eqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3qqLBm0xV4mGiZiGED2yL3VCWOwhq7//Y+5w9DIVSJI=;
        b=JVWzI3wGKhlH5l4KcPBtOt7EXDFufiY+3L4DK7XcAtClZTa8o7lLTTnoMV9wUK2TlE
         CYm5AuQOicFfdRNyrnZrPQocZ+t4W9m4+T2WuxRK/QIhGd/yIvD2EdcqhtAvnzMW3lnJ
         LlY8UZ+4LRRxTJSpa2XxEaQM5ygA9fd+qYAr0Q66eiiV6mcDx3ZJZRnsjJMqgyofXulB
         W688ppVz5fLyZIKdPxaAw/3XQp0norYx+iAw+FWYbwhRjm5HdYwoqB0cijl8Q2dBRA2U
         WRZMFmi7FVrY3ZcBhPMsShYgufkzldRim/2zvt1KmzouO5pp+/3MK1yszcPCAGsp95F6
         EPhg==
X-Gm-Message-State: AJIora9pRT3Cw7lExkHveKNf0EfeK0l0gNKAKUlVFSTO+dAHKRDCiGzV
        ja3VXuuCxrvYXoiRP3TyiKFqrzzGDocr
X-Google-Smtp-Source: AGRyM1uZdQcBK6hty151dQMWVvCDDhnb4BKYuP5NQXINp9lg2nYuagDD1EdnHpKZhALTM7g/t8iBQvOpY2zB
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90a:2a0d:b0:1f2:aed:ce18 with SMTP id
 i13-20020a17090a2a0d00b001f20aedce18mr999590pjd.91.1658515501311; Fri, 22 Jul
 2022 11:45:01 -0700 (PDT)
Date:   Fri, 22 Jul 2022 11:44:54 -0700
Message-Id: <20220722184455.3926696-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [kernel PATCH v1 0/1] Bluetooth: Return error if controller not
 support ll privacy
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Return proper error message if the controller does not support ll
privacy.


Changes in v1:
- Return proper mgmt error if controller does not support ll privacy

Zhengping Jiang (1):
  Bluetooth: Return error if controller not support ll privacy

 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.37.1.359.gd136c6c3e2-goog

