Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39092C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Apr 2022 13:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiDWNXl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Apr 2022 09:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiDWNXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:23:39 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9039021ED2C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:20:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id j8so16792280pll.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:from:to:cc:subject:content-transfer-encoding
         :mime-version;
        bh=VDVJNwQC9G2do4EJBoyXwI4wMV7uzIa5s7Tu2i6+M9E=;
        b=Bs7f1pBUxrJOx1Rb0toQohquDrucGeqqkWPzhxTr0mv7EinNNsw0MMLSNPa43FrUFM
         +9yozL9+zmGAsy9gJyXXz7JT2iiCwXz6u/lDiCdSKwZLAOQ5HkjG6jQ+74XMKwL8zONf
         huUa6t0LQkVgxjk88rh+Tz5Xg/LF7OqsLkjGR/W1qvyDQ2uahuRAV28vCgxe4F0b+mCL
         +Tk/vFbZ5JLjtrBae/XeNDRiUo2aNZs67iorzLeCRG37QbxtaOBMTnE6Ov8BE+eipYe8
         SpmhZdkBBMkmSrAEG2MzlPNbnYesRhFAap9dBoOAI1uY0hcsBBO6wiQrV9A9V4tUhz6r
         8K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=VDVJNwQC9G2do4EJBoyXwI4wMV7uzIa5s7Tu2i6+M9E=;
        b=m2X369wkRecYxlWqgPEER/Fnn/uZmsqrxp7OpZ0UlVqCqRf4/dQ/j9vOrytbqP+0eS
         wvtx+gF5BsnrWtKArPO4xLXUPfEkUjWDKwhRCwGkXYIIv2TJV1nWrWRk1Y+fK40hCpqL
         7o8rIWyLeRxjE6mGoTA6vp1H6gmpHMXjFyoe7K3+gQmOlhutc1nf2UTBUiChfyIoFMh+
         aOX36vxTM3Io+9eiA3bNNL+JDyCPaYIFT+lwtZJGyx/B56FodA28gjqfnFa/yUrko+Uh
         uTQ5itY6VtMR5EiNYyoUw03++/J3Yyfx0FBBMnADK1bAduPdbK9sFcI0ICSR/9QNH1W7
         8Sxg==
X-Gm-Message-State: AOAM532k/7+kw5UO+AZJx1kmH4FlrpgT5X+0EvzK9pupTV71fmvxL4rv
        Vvt62pv6NHkdgpl8+GJDFS9UPw==
X-Google-Smtp-Source: ABdhPJxfKVSxWejtjcVFh8TGSWjzQeoSzwsegywog51PDLCITMfQLii4o/sbsCv9kPQUs+gGoqT1Ng==
X-Received: by 2002:a17:902:ea53:b0:15b:1bb8:ac9e with SMTP id r19-20020a170902ea5300b0015b1bb8ac9emr9132837plg.45.1650720042137;
        Sat, 23 Apr 2022 06:20:42 -0700 (PDT)
Received: from [127.0.1.1] (117-20-68-98.751444.bne.nbn.aussiebb.net. [117.20.68.98])
        by smtp.gmail.com with UTF8SMTPSA id f19-20020a17090a639300b001d81a30c437sm2024788pjj.50.2022.04.23.06.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:20:41 -0700 (PDT)
Date:   Sat, 23 Apr 2022 13:20:35 +0000
Message-Id: <20220423132035.238704-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: dsa: mv88e6xxx: Skip cmode writable for mv88e6*41 if unchanged
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mv88e6341_port_set_cmode function always calls the set writable
regardless of whether the current cmode is different from the desired
cmode. This is problematic for specific configurations of the mv88e6341
and mv88e6141 (in single chip adddressing mode?) where the hidden
registers are not accessible. This causes the set_cmode_writable to
fail, and causes teardown of the switch despite the cmode already being
configured in the correct mode (via external configuration).

This change adds checking of the current cmode compared to the desired
mode and returns if already in the desired mode. This skips the
set_cmode_writable setup if the port is already configured in the
desired mode, avoiding any issues with access of hidden registers.

Signed-off-by: Nathan Rossi <nathan@nathanrossi.com>
---
 drivers/net/dsa/mv88e6xxx/port.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 795b312876..f2e9c8cae3 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -713,6 +713,7 @@ int mv88e6341_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
 			     phy_interface_t mode)
 {
 	int err;
+	u8 cmode = chip->ports[port].cmode;
 
 	if (port != 5)
 		return -EOPNOTSUPP;
@@ -724,6 +725,23 @@ int mv88e6341_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
 	case PHY_INTERFACE_MODE_XAUI:
 	case PHY_INTERFACE_MODE_RXAUI:
 		return -EINVAL;
+
+	/* Check before setting writable. Such that on devices that are already
+	 * correctly configured, no attempt is made to make the cmode writable
+	 * as it may fail.
+	 */
+	case PHY_INTERFACE_MODE_1000BASEX:
+		if (cmode == MV88E6XXX_PORT_STS_CMODE_1000BASEX)
+			return 0;
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		if (cmode == MV88E6XXX_PORT_STS_CMODE_SGMII)
+			return 0;
+		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		if (cmode == MV88E6XXX_PORT_STS_CMODE_2500BASEX)
+			return 0;
+		break;
 	default:
 		break;
 	}
---
2.35.2
