Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A32FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 22:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbiDEWeC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 18:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbiDEKsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:48:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2AF6BDCA;
        Tue,  5 Apr 2022 03:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55192B81C8B;
        Tue,  5 Apr 2022 10:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E63C385A2;
        Tue,  5 Apr 2022 10:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649154446;
        bh=fVddxG7foRUD0b9S/5Aoy8HafQiqvV5cOa2bUFKvuUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYYV7r5w6Z0Yj5NVfkCdGulAqgUGlR2yBRmiJhsovNxYOAV7wPpjuGrwFx/1e5N7J
         3gix65z2IHOtEVyNkJO6WKZPFYyqWSFr5NCWwAPfJuqoHpVLirBxioSRNoqyTJQcm1
         9ayLuGtQGY/j+P5/05QEv0SfFq/Qeo/DnDDbYPgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.10 582/599] dt-bindings: mtd: nand-controller: Fix the reg property description
Date:   Tue,  5 Apr 2022 09:34:36 +0200
Message-Id: <20220405070316.162782212@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 93f2ec9e401276fb4ea9903194a5bfcf175f9a2c upstream.

The reg property of a NAND device always references the chip-selects.
The ready/busy lines are described in the nand-rb property. I believe
this was a harmless copy/paste error during the conversion to yaml.

Fixes: 212e49693592 ("dt-bindings: mtd: Add YAML schemas for the generic NAND options")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/linux-mtd/20211216111654.238086-2-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/mtd/nand-controller.yaml |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -44,7 +44,7 @@ patternProperties:
     properties:
       reg:
         description:
-          Contains the native Ready/Busy IDs.
+          Contains the chip-select IDs.
 
       nand-ecc-mode:
         description:


