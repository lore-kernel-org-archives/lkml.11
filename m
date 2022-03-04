Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56168C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 11:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbiCDLa5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 06:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239575AbiCDLav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:30:51 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBDA155C3C;
        Fri,  4 Mar 2022 03:30:03 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t5so7393619pfg.4;
        Fri, 04 Mar 2022 03:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8h85EqRRCLiGL53ycW8kr7mXUB11CVEXR9UMxVb4BkI=;
        b=LtruXqJBf79xHTqXkhttmi7F4MMrxTC4jzgT3oDue5YoUczjkcLzR/288VLZi+om7w
         KstnsUmjYyUIqfHpokSxOLlNQ+WtCCSf1xjgUAXG4Wr5snl9gZ+/hMcayXaZf4AYpW6G
         OHxlYfurYVQBg0pdU4LyLjbrTLdesUbhc23Jixnfq8yomdUx1Q39jC1c690Uz8LfSUWm
         nguqN/KiLsQu2W8Bv9flRw1ZjMpvyTXcBw3OwDMxfX6XdFvQC2MkQlpiHIITp28NreP1
         JHkdp27nEmMG7qiA6WE7fm0QJaHAn8IhMPbZVkzjfddGtRcvEKq7AOx6DHI3wN8+Z4RM
         DXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8h85EqRRCLiGL53ycW8kr7mXUB11CVEXR9UMxVb4BkI=;
        b=Xm6gMhGB+uuliiDbdVNsmEE/DMHOB1JeYwrZQGCVPTPIH0mE7ZR8rhfnZBlBcVMZY6
         FHr2SCsA0U41Hz2lezbWlTo0w+SbtfYXXWsOHNNsJWOc1taotpGYdJ0g3UOqmGGQ1oZb
         2r9DlaOEa2JtUvIA18uMz4A4n4QcmhCUtzgBxcfiZ9OfeYiHGdZWpV+5NEBqaYPeAc4k
         bwEL8hlLxiHe7H6ol8NhT3bGokMggN+v/RHbjSJotxp84+sQTIOeVbo4ciov2dburhTv
         xhDxtjmb2Ty1dbi2tIiqkAchMo2cJxMa7quqhvM2boN/4WVZLeqHWAskukQvXSYY+GPW
         qUGw==
X-Gm-Message-State: AOAM530EKPucDx6hQzyp3w8yXFLSNIYLsMOXwaxigk+hpPgGFmts8C9s
        VfGdS41Q5zqVRtRpAPgGZSk=
X-Google-Smtp-Source: ABdhPJwqxIBJuIn5XpOvRpZQlQgIg+Pos7BA0dFdg5JsK54IWbBXXykhk/Gco+jvsDeoR+xFlHeGBA==
X-Received: by 2002:a05:6a00:2301:b0:4e1:5842:48d7 with SMTP id h1-20020a056a00230100b004e1584248d7mr43017387pfh.14.1646393402652;
        Fri, 04 Mar 2022 03:30:02 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h3-20020a056a00170300b004f104c635e4sm5718237pfc.99.2022.03.04.03.30.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 03:30:02 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v1 0/2] Add phy driver for ehci in Sunplus SP7021
Date:   Fri,  4 Mar 2022 19:30:16 +0800
Message-Id: <1646393418-26421-1-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for ehci driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Coretex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Vincent Shih (2):
  phy: usb: Add USB2.0 phy driver for Sunplus SP7021
  dt-bindings: phy: Add bindings doc for Sunplus USB2 PHY driver

 .../bindings/phy/sunplus,sp7021-usb2-phy.yaml      |  73 ++++++
 MAINTAINERS                                        |   9 +
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/sunplus/Kconfig                        |  12 +
 drivers/phy/sunplus/Makefile                       |   2 +
 drivers/phy/sunplus/phy-sunplus-usb2.c             | 248 +++++++++++++++++++++
 7 files changed, 346 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
 create mode 100644 drivers/phy/sunplus/Kconfig
 create mode 100644 drivers/phy/sunplus/Makefile
 create mode 100644 drivers/phy/sunplus/phy-sunplus-usb2.c

-- 
2.7.4

