Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BB6C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 21:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiBPV0B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 16:26:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiBPVZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 16:25:55 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF692AFE82;
        Wed, 16 Feb 2022 13:25:41 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 3D935C400F;
        Wed, 16 Feb 2022 21:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645046740; bh=5zUmw/zow/u8ki633uBGGUp5NCV/on7v/jtAHqOnW7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=il0mxu/GatCCc9wR0fsjIF0HOtjCRoDDH8kwixyjS19Hxk1WixgOssPCUpE9U6olW
         iMHvVvcOiYpdZV/lFC+XDaXd8IF7JQm8pWROIJCrDmeaRdajZUh4GQKHT9472Xi/GX
         9R+PAtWQaHg1Ev6jPRr7V7WsYk0WlN/Ec2JzuTdQ=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: bluetooth: broadcom: add BCM43430A0
Date:   Wed, 16 Feb 2022 22:24:28 +0100
Message-Id: <20220216212433.1373903-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216212433.1373903-1-luca@z3ntu.xyz>
References: <20220216212433.1373903-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible string for BCM43430A0 bluetooth.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
index 5aac094fd217..c11cd9bc9f9c 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
@@ -19,6 +19,7 @@ properties:
       - brcm,bcm4329-bt
       - brcm,bcm4330-bt
       - brcm,bcm4334-bt
+      - brcm,bcm43430a0-bt
       - brcm,bcm43438-bt
       - brcm,bcm4345c5
       - brcm,bcm43540-bt
-- 
2.35.1

