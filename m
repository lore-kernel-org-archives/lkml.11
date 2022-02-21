Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3D8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 10:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353258AbiBUKWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 05:22:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354358AbiBUKVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:21:53 -0500
Received: from outbound-smtp23.blacknight.com (outbound-smtp23.blacknight.com [81.17.249.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC85F20C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:41:32 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp23.blacknight.com (Postfix) with ESMTPS id 1121E102129
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:41:31 +0000 (GMT)
Received: (qmail 31555 invoked from network); 21 Feb 2022 09:41:30 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 21 Feb 2022 09:41:30 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v2 0/6] More follow-up on high-order PCP caching
Date:   Mon, 21 Feb 2022 09:41:18 +0000
Message-Id: <20220221094119.15282-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is one patch on top of the series "Follow-up on high-order PCP
caching" that is already in mmotm.

The series left prefetching in place but as the batch freeing of PCP
pages now all happens under the zone lock, it's unlikely there is enough
time for the prefetching to have a benefit so remove it.

 mm/page_alloc.c | 24 ------------------------
 1 file changed, 24 deletions(-)

-- 
2.26.2

