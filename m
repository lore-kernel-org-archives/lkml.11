Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAA3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 15:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347980AbiCXPRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 11:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiCXPRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:17:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFA3ABF4C;
        Thu, 24 Mar 2022 08:16:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69672617F2;
        Thu, 24 Mar 2022 15:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AEDC340F2;
        Thu, 24 Mar 2022 15:16:08 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Grant Likely <grant.likely@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] Documentation/process: Update ARM contact for embargoed hardware issues
Date:   Thu, 24 Mar 2022 15:16:05 +0000
Message-Id: <20220324151605.266645-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Grant taking a prominent role in Linaro, I will take over as the
process ambassador for ARM w.r.t. embargoed hardware issues.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Grant Likely <grant.likely@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/embargoed-hardware-issues.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 6f8f36e10e8b..41a2afaaea75 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -244,7 +244,7 @@ disclosure of a particular issue, unless requested by a response team or by
 an involved disclosed party. The current ambassadors list:
 
   ============= ========================================================
-  ARM           Grant Likely <grant.likely@arm.com>
+  ARM		Catalin Marinas <catalin.marinas@arm.com>
   AMD		Tom Lendacky <tom.lendacky@amd.com>
   IBM Z         Christian Borntraeger <borntraeger@de.ibm.com>
   IBM Power     Anton Blanchard <anton@linux.ibm.com>
