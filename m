Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7CDC4321E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 07:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359061AbiDLHm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 03:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353790AbiDLHQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:16:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB9241604;
        Mon, 11 Apr 2022 23:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E74560EEB;
        Tue, 12 Apr 2022 06:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9760CC385A1;
        Tue, 12 Apr 2022 06:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649746650;
        bh=J+IzGTWnEZGe/MKM2rGhq26NMXflsdebyu/IUCQhgJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kppuP2Z/nNwb5OzPStmOtAKAx3maECCUgcKzFNXBweylxdfeLQBzbzBl7uGho7N52
         qwk7eZ7NMjVPj5y2jHicUVd4BTiJ1FMgeXV8a1QrIoVCHgrUBzl32MxV19yEuZK4Aj
         a+N1wAJOk8qrmMMe4YV9ntJKrKbEZXHtP74+YQz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 082/285] mips: ralink: fix a refcount leak in ill_acc_of_setup()
Date:   Tue, 12 Apr 2022 08:28:59 +0200
Message-Id: <20220412062946.030512089@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062943.670770901@linuxfoundation.org>
References: <20220412062943.670770901@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangyu Hua <hbh25y@gmail.com>

[ Upstream commit 4a0a1436053b17e50b7c88858fb0824326641793 ]

of_node_put(np) needs to be called when pdev == NULL.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/ralink/ill_acc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ralink/ill_acc.c b/arch/mips/ralink/ill_acc.c
index bdf53807d7c2..bea857c9da8b 100644
--- a/arch/mips/ralink/ill_acc.c
+++ b/arch/mips/ralink/ill_acc.c
@@ -61,6 +61,7 @@ static int __init ill_acc_of_setup(void)
 	pdev = of_find_device_by_node(np);
 	if (!pdev) {
 		pr_err("%pOFn: failed to lookup pdev\n", np);
+		of_node_put(np);
 		return -EINVAL;
 	}
 
-- 
2.35.1



