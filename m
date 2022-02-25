Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF86BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 20:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbiBYUrl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbiBYUri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:47:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06C321DF08;
        Fri, 25 Feb 2022 12:47:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3779E61A39;
        Fri, 25 Feb 2022 20:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421B5C340E7;
        Fri, 25 Feb 2022 20:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645822024;
        bh=BgwFCB+nKC3SRlS7et+uFSYIZ+NQB/a+ehhlWdZF9ek=;
        h=From:To:Cc:Subject:Date:From;
        b=tfi1tk1NBr5aceiuIy/FLUjHb+kTNsjvkNXMaSWhmyHJCrw7MDz9S9XZUtitjVYe3
         0fJTXW+ahVr8OFBqoVz/W44K2rFKnQ/og+BUc6donqcjT/Lo7MwUOPyrSron9Z4sp6
         MdDZSk6ErFcFZJS5jaHZ1qdwpNbXXWzp+A3RAaU29eqXBiZRkEwjtyFv/NK43DE2eu
         e11SR1jgGZ0NKMvveyyWQ3z/D1H/qK9qbvWSmZo16dkJLv5vLdkpUNOrGnYfjUqk5D
         8+wBD7FAk+Igr0uTrp/D0yPRP7n2a+AcKZF5aHdVcSd3wNNngYEEHjbiFPlpgxjui+
         1Qm40hKGNh1tg==
From:   broonie@kernel.org
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: linux-next: manual merge of the extcon tree with the battery tree
Date:   Fri, 25 Feb 2022 20:46:58 +0000
Message-Id: <20220225204658.4006482-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the extcon tree got a conflict in:

  drivers/power/supply/max8997_charger.c

between commit:

  fdc9ce72cffea ("power: supply: max8997_charger: Use devm_work_autocancel()")

from the battery tree and commit:

  e77e52e00b184 ("extcon: Fix extcon_get_extcon_dev() error handling")

from the extcon tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/power/supply/max8997_charger.c
index 127c73b0b3bd7,634658adf313f..0000000000000
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@@ -242,15 -248,15 +242,15 @@@ static int max8997_battery_probe(struc
  		dev_info(&pdev->dev, "couldn't get charger regulator\n");
  	}
  	charger->edev = extcon_get_extcon_dev("max8997-muic");
- 	if (IS_ERR_OR_NULL(charger->edev)) {
- 		if (!charger->edev)
- 			return -EPROBE_DEFER;
- 		dev_info(charger->dev, "couldn't get extcon device\n");
+ 	if (IS_ERR(charger->edev)) {
+ 		dev_err_probe(charger->dev, PTR_ERR(charger->edev),
+ 			      "couldn't get extcon device: max8997-muic\n");
+ 		return PTR_ERR(charger->edev);
  	}
  
- 	if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
+ 	if (!IS_ERR(charger->reg)) {
 -		INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
 -		ret = devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_work, charger);
 +		ret = devm_work_autocancel(&pdev->dev, &charger->extcon_work,
 +					   max8997_battery_extcon_evt_worker);
  		if (ret) {
  			dev_err(&pdev->dev, "failed to add extcon evt stop action: %d\n", ret);
  			return ret;
