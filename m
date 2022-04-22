Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EE2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 06:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444395AbiDVGaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 02:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444348AbiDVG35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:29:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD65450B1F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:27:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 818C6B82A95
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6399C385A4;
        Fri, 22 Apr 2022 06:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650608822;
        bh=Jqe4X1wkd2fVgjl3MmWermpy5+W1eWq4Gx/npLUOsVY=;
        h=From:To:Cc:Subject:Date:From;
        b=I+icmn8TWSM+B0iIk1J0+0SgVxGgu/Mv5TWGQfR+BdMVQFCFtepFaT5Bae2ZDWU9Y
         mRyMJy7Nh7xZqsprG2Dl363X7I7MDwq4PSGSi/dnOjLyNhpi4x4YS0byIaQF73Aspf
         Zx+yvbThxGfP6vdsZzrTbbJmscLMD3XOUmf1JCSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] topology: Fix up build warning in topology_is_visible()
Date:   Fri, 22 Apr 2022 08:26:53 +0200
Message-Id: <20220422062653.3899972-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=gregkh@linuxfoundation.org; h=from:subject; bh=Jqe4X1wkd2fVgjl3MmWermpy5+W1eWq4Gx/npLUOsVY=; b=owGbwMvMwCRo6H6F97bub03G02pJDElJXqvP3L65Yn7Qy92SPna6gqcNnm3bGdUrMT87X75/59n2 dEaPjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhI5SSGeebrtj75zv4t1l9kxomIt9 8WvNTt62VYsOFNPcPMSxuqjivbxXyKM9yQ0LfrAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aa63a74d4535 ("topology/sysfs: Hide PPIN on systems that do not
support it.") caused a build warning on some configurations:

drivers/base/topology.c: In function 'topology_is_visible':
drivers/base/topology.c:158:24: warning: unused variable 'dev' [-Wunused-variable]
  158 |         struct device *dev = kobj_to_dev(kobj);

Fix this up by getting rid of the variable entirely.

Fixes: aa63a74d4535 ("topology/sysfs: Hide PPIN on systems that do not support it.")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/topology.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 706dbf8bf249..ac6ad9ab67f9 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -155,9 +155,7 @@ static struct attribute *default_attrs[] = {
 static umode_t topology_is_visible(struct kobject *kobj,
 				   struct attribute *attr, int unused)
 {
-	struct device *dev = kobj_to_dev(kobj);
-
-	if (attr == &dev_attr_ppin.attr && !topology_ppin(dev->id))
+	if (attr == &dev_attr_ppin.attr && !topology_ppin(kobj_to_dev(kobj)->id))
 		return 0;
 
 	return attr->mode;
-- 
2.36.0

