Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CB2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 12:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiCNMZx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242538AbiCNMTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:19:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF134F475;
        Mon, 14 Mar 2022 05:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9920CB80DF9;
        Mon, 14 Mar 2022 12:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9525C340ED;
        Mon, 14 Mar 2022 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647260057;
        bh=m8jRNaz/jrCc7HEoFVxnZs1a2N3/lU3a7CW7j0amyek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6R/OGQYu/cZ8nnPElkE7Kp5KzKNXJ5qcozwrJejaTfa+yfxCkgrE9MbrEwqkeoov
         WVuLNFSdAI+HMNCJv65ScIqNp1kKvIxy9/yJbbMroIXkPFNRUep+XZIHs6iFimff2X
         haUl0R6jj+cilX9B5XyMsSCLhqQUqSGx6VcLZAtA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 043/121] net: marvell: prestera: Add missing of_node_put() in prestera_switch_set_base_mac_addr
Date:   Mon, 14 Mar 2022 12:53:46 +0100
Message-Id: <20220314112745.329830316@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314112744.120491875@linuxfoundation.org>
References: <20220314112744.120491875@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit c9ffa3e2bc451816ce0295e40063514fabf2bd36 ]

This node pointer is returned by of_find_compatible_node() with
refcount incremented. Calling of_node_put() to aovid the refcount leak.

Fixes: 501ef3066c89 ("net: marvell: prestera: Add driver for Prestera family ASIC devices")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/prestera/prestera_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index c687dc9aa973..36c5b1eba30d 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -553,6 +553,7 @@ static int prestera_switch_set_base_mac_addr(struct prestera_switch *sw)
 		dev_info(prestera_dev(sw), "using random base mac address\n");
 	}
 	of_node_put(base_mac_np);
+	of_node_put(np);
 
 	return prestera_hw_switch_mac_set(sw, sw->base_mac);
 }
-- 
2.34.1



