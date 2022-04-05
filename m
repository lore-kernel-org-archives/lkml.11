Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72007C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 10:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355975AbiDEKWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241259AbiDEIc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E3B62E7;
        Tue,  5 Apr 2022 01:30:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C345EB81BC0;
        Tue,  5 Apr 2022 08:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A638C385A1;
        Tue,  5 Apr 2022 08:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147448;
        bh=+1uthk7lYAmO9wnvrPL07V5fVwTvslmy0jK66nFRxSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOuy0ZbkdOYAwGAeRdjF1q+cNfGzra1iJp4b1QwOk6ovYMBQEHg/Qvb4tNGGdKxAn
         zLkAtKIiz7G4nHprXbF3tG8+3OsD25aC3VP32mWFHXrmVnXhhcQZ5nkpZ7mTtNSYJX
         GL1qG+DYM/Z1aHlgn/+7qTig+w1FCxuqhah++JsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.17 1089/1126] dt-bindings: mtd: nand-controller: Fix the reg property description
Date:   Tue,  5 Apr 2022 09:30:36 +0200
Message-Id: <20220405070439.413895406@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
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
@@ -55,7 +55,7 @@ patternProperties:
     properties:
       reg:
         description:
-          Contains the native Ready/Busy IDs.
+          Contains the chip-select IDs.
 
       nand-ecc-engine:
         allOf:


