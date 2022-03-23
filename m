Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 15:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245153AbiCWP0U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 11:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245143AbiCWP0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:26:15 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37936E79E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648049085; x=1679585085;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=OwPLDU5ROJx7nbiAvFUSiXwLBzuvc8gPh6XC+2xjHbM=;
  b=pHttAllXElvSSZYfiwCKJQ6jsOtQjTsdu2TmeRyN5tMLzuDgdBdshb3g
   OW4uflVKJZQiBcqr/0BTMCGUCaxQMbiD6pLgI4ocECnBhDyS5jUd+YQmE
   UG1P/bwvAjyRQkX+eW/ryLt6f1MhaD3SujzhtJdGE235C14I3RJ01KkPm
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Mar 2022 08:24:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 08:24:44 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 08:24:44 -0700
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 08:24:40 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <minchan@kernel.org>, <surenb@google.com>, <vbabka@suse.cz>,
        <rientjes@google.com>, <nadav.amit@gmail.com>,
        <edgararriaga@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH 0/2] mm: madvise: return exact bytes advised with process_madvise under error
Date:   Wed, 23 Mar 2022 20:54:08 +0530
Message-ID: <cover.1648046642.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under error conditions, process_madvise() is not returning the exact
bytes processed in a iovec element thus user may repeat the advise on
vma ranges contained in the iovec element despite those ranges are
already processed. This problem is partially solved with commit
08095d6310a7 ("mm: madvise: skip unmapped vma holes passed to
process_madvise") for ENOMEM return types. These patches try to solve
the problem for other error return types.

Starting this as new discussion, as the back ground for these changes
are coming from below patches, which are already merged into linus tree:
1) https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5bd009c7c9a9e888077c07535dc0c70aeab242c3
2) https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=08095d6310a7ce43256b4251577bc66a25c6e1a6

and lore archives for the above changes:
1) V2: https://lore.kernel.org/linux-mm/cover.1647008754.git.quic_charante@quicinc.com/
2) V1: https://lore.kernel.org/linux-mm/1646803679-11433-1-git-send-email-quic_charante@quicinc.com/

Charan Teja Kalla (1):
  Revert "mm: madvise: skip unmapped vma holes passed to
    process_madvise"

Charan Teja Reddy (1):
  mm: madvise: return exact bytes advised with process_madvise under
    error

 mm/madvise.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 88 insertions(+), 11 deletions(-)

-- 
2.7.4

