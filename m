Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8E5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 15:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386767AbiFMPOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 11:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243709AbiFMPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:12:19 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271561124FF;
        Mon, 13 Jun 2022 05:26:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id h23so10801235ejj.12;
        Mon, 13 Jun 2022 05:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8xxTI3Ss0WMvQnCIvX3BWtfdOokaW3JYdk6viarNn2w=;
        b=B1eSHARb/HLRNxEiVUfS1gBgMUu/eKrY6+Ta+1Q1t0zBUYPMNoSNzILph/rg7s0DzS
         5eY882OPO0TS8avEouSr+LlWRxN8metr9VffuR2NfLOo6r04qRV4ys5LymAbLq165f5f
         omuxsbxHRt9qbWwtdxOdXLXH34RbTwZy7XiMoGI0p+pBLUgCSbNNn/ipvwEOPfWMbncP
         /CVPd3oR1ReKpmSf2XKHAqw9bOtE5N2dNU9CncxQLy5zwpLf3Z4cz91VfLWNR4/I8PQP
         Lf83icvbbTYMLqkHeX62zix3xAFqsok+Bls27pUQnXBR18X2N1dqz1dQn61yeTiyHTm2
         6bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8xxTI3Ss0WMvQnCIvX3BWtfdOokaW3JYdk6viarNn2w=;
        b=F+QuIVjLL+F/wVE1E4Y6Nm5zu6olBnMWIf/grbywWkCYt6xYTVWzM+46ThGNvQAUeF
         Z/y8zEj6tCLftExAABTvyGhnPw7g5oPVjybKr4XEoVlWIVEtvz5RTfA/RZw/u1eljCDU
         Sa8LWONm1J4VFth3716usrn3mQ+Le+qy4SzGSbxHHJQ4hmaoo/56Vt2kJH/8WpXqi3gT
         6XDU/wJ8HDWY3yZGIpPg2UhX9CyPlwe9zr1eeu1RJKguQVmh80NQgE7qtv6RwJb6u/Nq
         5e4b6CpgqrHVxGsI7XweQhQr0FuV32ZCeY0dRFexGm3H/vdo+a9zZI0LXvsq9WKPt2Bk
         UoPg==
X-Gm-Message-State: AOAM531WJ0R/zbbPLhG4KK1OILp2nW9tw30VfrqQHSmTg3vEYstve5Zr
        ne21rCzdopa7VmpwIH+NJbg=
X-Google-Smtp-Source: ABdhPJxRkJaL5XerCne7Kfki+B7OYlwwm15OKT/e9vP7mHjOQ4NDXwo7swD6zqhara4IBUTcU3F9Fg==
X-Received: by 2002:a17:906:20c6:b0:718:cc95:ccaf with SMTP id c6-20020a17090620c600b00718cc95ccafmr2226111ejc.714.1655123194323;
        Mon, 13 Jun 2022 05:26:34 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50011e978c0f780de03.dip.versatel-1u1.de. [2001:16b8:260d:f500:11e9:78c0:f780:de03])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906308c00b006ff0b457cdasm3768403ejv.53.2022.06.13.05.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:26:33 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/phy to GENERIC PHY FRAMEWORK
Date:   Mon, 13 Jun 2022 14:26:21 +0200
Message-Id: <20220613122621.18397-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintainers of the directory Documentation/devicetree/bindings/phy
are also the maintainers of the corresponding directory
include/dt-bindings/phy.

Add the file entry for include/dt-bindings/phy to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Kishon, Vinod, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bb8a8724eaf..7a4c3e811262 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8354,6 +8354,7 @@ Q:	https://patchwork.kernel.org/project/linux-phy/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
 F:	Documentation/devicetree/bindings/phy/
 F:	drivers/phy/
+F:	include/dt-bindings/phy/
 F:	include/linux/phy/
 
 GENERIC PINCTRL I2C DEMULTIPLEXER DRIVER
-- 
2.17.1

