Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E5ECCA473
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 13:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiFFNqR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 09:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbiFFNqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:46:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C4B241230
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:46:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q1so29073256ejz.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RyE/5WkFj4kqlM+hYKkTtPD1/Znyp8cf8vJddwwLwqc=;
        b=X2xiglIlatM2mHhAVLnJFiDCXvluwipGFTj/XlHQyveUL9xOTRIieaAtU8TGPNGFUi
         VlWUgrHV1wVRPumV4Se6O3GnFdP4bZpKaPwRDzx6lJv2s+Kzka/MCpraBHx2SXdnhGoh
         azcw+UNvxOSBfDYYdGcM867GBBU3m3a5j85z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RyE/5WkFj4kqlM+hYKkTtPD1/Znyp8cf8vJddwwLwqc=;
        b=XJtCsRTollGun8wvbNRIQxmv6oFBPvyiyr9RhTNjp758ioRzmkpDSA3Ud69whFK9xN
         qelySE2BD+g9qN2wWLK/XxuUMHfxZVOeyIcN+PaSliDbCsGO3YY3+4UiI9qV9EqAwy9C
         5UAyTBh+MubKg+qZYBG4s6nfsG7CnvzKmdIeAeofb3W+0SlxiPaV63EPjAbiPb8EWBhj
         Q63W0SbS6Cph1maFR1usYAexhqKZ8XOzrD74a1InA635ebzpjC8zkTsPFoALNt0yCZfK
         Ndd1WgkGBw46SQv7VwfYsHCxeZ5k1dZAVKFteFsBrUEtp9uHOmhh8as4PVtZMxMnGXTB
         BXUQ==
X-Gm-Message-State: AOAM531TJArQTPG40ric398MNiSX16B1Y/Qzzzcmh2MzfdNb+3Wpukcv
        c0UDNsKFOBusOv3NMa6dOr+LvQ==
X-Google-Smtp-Source: ABdhPJyw8lLr0zTjgm1NfJVlGHX1hiA8EEPgexnjx8LGyqOURB5i6kJLJIgcQDe3DvCCb664NKohag==
X-Received: by 2002:a17:906:27d4:b0:710:9a8a:85ef with SMTP id k20-20020a17090627d400b007109a8a85efmr11447815ejc.136.1654523171163;
        Mon, 06 Jun 2022 06:46:11 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id a26-20020a1709062b1a00b006f3ef214db4sm5496538ejg.26.2022.06.06.06.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 06:46:10 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     luizluca@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: dsa: realtek: rtl8365mb: improve handling of PHY modes
Date:   Mon,  6 Jun 2022 15:45:48 +0200
Message-Id: <20220606134553.2919693-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

This series introduces some minor cleanup of the driver and improves the
handling of PHY interface modes to break the assumption that CPU ports
are always over an external interface, and the assumption that user
ports are always using an internal PHY.

Alvin Šipraga (5):
  net: dsa: realtek: rtl8365mb: rename macro RTL8367RB -> RTL8367RB_VB
  net: dsa: realtek: rtl8365mb: remove port_mask private data member
  net: dsa: realtek: rtl8365mb: correct the max number of ports
  net: dsa: realtek: rtl8365mb: remove learn_limit_max private data
    member
  net: dsa: realtek: rtl8365mb: handle PHY interface modes correctly

 drivers/net/dsa/realtek/rtl8365mb.c | 268 ++++++++++++++++++++--------
 1 file changed, 189 insertions(+), 79 deletions(-)

-- 
2.36.0

