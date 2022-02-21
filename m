Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544F1C4707A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 10:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354072AbiBUKCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 05:02:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352336AbiBUJzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:55:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5231387AC;
        Mon, 21 Feb 2022 01:24:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EEB2B80EB9;
        Mon, 21 Feb 2022 09:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACA4C340E9;
        Mon, 21 Feb 2022 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645435449;
        bh=1RWRw81HnhA40n4kQ9w8rLZmB3UuvQzSg293F+N1jEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkLQKIZoeeTHktGpOheE7PlY84PlmG3plrcuqkmlZm0EJKvstjciNWTAbBevIT1h9
         JaMm1Ffcbh5neyNVHf7uOhldYpkmVm+SACT2jJ9TDTfPANqQddTUwy+yJtqt9i/gv9
         VnyHtTGJz0Ed19y6jdhLgzvZgU54Z+WDwKypVFQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.16 167/227] mtd: parsers: qcom: Fix missing free for pparts in cleanup
Date:   Mon, 21 Feb 2022 09:49:46 +0100
Message-Id: <20220221084940.375889431@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084934.836145070@linuxfoundation.org>
References: <20220221084934.836145070@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ansuel Smith <ansuelsmth@gmail.com>

commit 3dd8ba961b9356c4113b96541c752c73d98fef70 upstream.

Mtdpart doesn't free pparts when a cleanup function is declared.
Add missing free for pparts in cleanup function for smem to fix the
leak.

Fixes: 10f3b4d79958 ("mtd: parsers: qcom: Fix leaking of partition name")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20220116032211.9728-2-ansuelsmth@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/parsers/qcomsmempart.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mtd/parsers/qcomsmempart.c
+++ b/drivers/mtd/parsers/qcomsmempart.c
@@ -173,6 +173,8 @@ static void parse_qcomsmem_cleanup(const
 
 	for (i = 0; i < nr_parts; i++)
 		kfree(pparts[i].name);
+
+	kfree(pparts);
 }
 
 static const struct of_device_id qcomsmem_of_match_table[] = {


