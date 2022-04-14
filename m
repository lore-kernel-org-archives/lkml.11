Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6575FC4332F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347331AbiDNOPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245569AbiDNNin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:38:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EEFA27EA;
        Thu, 14 Apr 2022 06:32:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85C89B82983;
        Thu, 14 Apr 2022 13:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75BCC385A1;
        Thu, 14 Apr 2022 13:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649943175;
        bh=AOOFPuXflGbfo9Wz9sgfd8G7JusKr8STzbXudF3Si5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yt+SNc/L+qjOViL2ZcTNuIr8/jMPYsYQUzQHurcEWwVKMOVe90DY+l5FyVE+ZPAmg
         OMXZsOntmJQcXESktBCmZihlJbdgKCozef3bwE4hWrfhHz5i36Ssg0p7fv0KKO+/la
         eEeLCpyjwKMV3go5rq9GUzpcBYA7/t0HjzegaCqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 062/475] ACPI: properties: Consistently return -ENOENT if there are no more references
Date:   Thu, 14 Apr 2022 15:07:27 +0200
Message-Id: <20220414110856.888143350@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110855.141582785@linuxfoundation.org>
References: <20220414110855.141582785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit babc92da5928f81af951663fc436997352e02d3a upstream.

__acpi_node_get_property_reference() is documented to return -ENOENT if
the caller requests a property reference at an index that does not exist,
not -EINVAL which it actually does.

Fix this by returning -ENOENT consistenly, independently of whether the
property value is a plain reference or a package.

Fixes: c343bc2ce2c6 ("ACPI: properties: Align return codes of __acpi_node_get_property_reference()")
Cc: 4.14+ <stable@vger.kernel.org> # 4.14+
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/property.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -692,7 +692,7 @@ int __acpi_node_get_property_reference(c
 	 */
 	if (obj->type == ACPI_TYPE_LOCAL_REFERENCE) {
 		if (index)
-			return -EINVAL;
+			return -ENOENT;
 
 		ret = acpi_bus_get_device(obj->reference.handle, &device);
 		if (ret)


