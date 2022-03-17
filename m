Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C72C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 12:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiCQM5e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 08:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiCQMyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:54:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E39F1F1619;
        Thu, 17 Mar 2022 05:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38413614FF;
        Thu, 17 Mar 2022 12:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAA3C340E9;
        Thu, 17 Mar 2022 12:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647521563;
        bh=zRZO4C73CEe0cGTlpqWmGRS66SbFnS+B8DijLjV/NHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aScqgrCZMgPHqgH8Mb9HLjnKlFQBURQcSapEiM04pjsA/ofi4nDa4LzikT9U3OcJQ
         mlFuxiZVXaTxQ1ftL4CeePRbMJHCvyamneqAs1XOyozLdBRYrHofpjlTX+QrLjmx9I
         OrTijIXtSUUvDkFyvsgd3hRq7W1oFv5dbnQnETPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 12/28] mac80211: refuse aggregations sessions before authorized
Date:   Thu, 17 Mar 2022 13:46:03 +0100
Message-Id: <20220317124527.118540315@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317124526.768423926@linuxfoundation.org>
References: <20220317124526.768423926@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit a6bce78262f5dd4b50510f0aa47f3995f7b185f3 ]

If an MFP station isn't authorized, the receiver will (or
at least should) drop the action frame since it's a robust
management frame, but if we're not authorized we haven't
installed keys yet. Refuse attempts to start a session as
they'd just time out.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/r/20220203201528.ff4d5679dce9.I34bb1f2bc341e161af2d6faf74f91b332ba11285@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/agg-tx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 74a878f213d3..1deb3d874a4b 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2021 Intel Corporation
+ * Copyright (C) 2018 - 2022 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -626,6 +626,14 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 		return -EINVAL;
 	}
 
+	if (test_sta_flag(sta, WLAN_STA_MFP) &&
+	    !test_sta_flag(sta, WLAN_STA_AUTHORIZED)) {
+		ht_dbg(sdata,
+		       "MFP STA not authorized - deny BA session request %pM tid %d\n",
+		       sta->sta.addr, tid);
+		return -EINVAL;
+	}
+
 	/*
 	 * 802.11n-2009 11.5.1.1: If the initiating STA is an HT STA, is a
 	 * member of an IBSS, and has no other existing Block Ack agreement
-- 
2.34.1



