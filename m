Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBEFC3F6B0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 01:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiHOBDj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Aug 2022 21:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHOBDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:03:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B17DFC1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660525417; x=1692061417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G6eV86D86/ueseZifBzMfch5iZxMZYRohCP6IporhPo=;
  b=cVRThrCemmZ78hWy9IFpbl3zbGGR3R1Ky88FX1vTGMNZ5b76tuwKacN9
   oqHbgfGnEnw15HRIoP7qpLJedy5+Qa64LF/Dxkg9jiD1icCdWLgixNGEp
   JVczdVovceJxMBn0AIi5iLlUG1Zc0cDlTPVQAGWIsMtDJ7tsfAVEUh5T1
   ZIOOYxrXp0BwYBy3iEadrGRcjwG55qQ3V1BaQQhKa2/ZZojFEHuHH6vp/
   G01dPWs6PCodtAHVaAMFvueIUofu6ewPxh+IDuju2/bTYrPsDPh2tuBfP
   fQbeTV9BmuSuL0lLLDwnQfKUi9dsMTFw8EYzcFguKWCsh3tbc+ONUxxew
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="355872159"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="355872159"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 18:03:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="695823574"
Received: from sse-cse-haiyue-nuc.sh.intel.com ([10.239.241.114])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Aug 2022 18:03:34 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, linmiaohe@huawei.com,
        ying.huang@intel.com, songmuchun@bytedance.com,
        naoya.horiguchi@linux.dev, alex.sierra@amd.com,
        Haiyue Wang <haiyue.wang@intel.com>
Subject: [PATCH v3 0/2] fix follow_page related issues
Date:   Mon, 15 Aug 2022 09:03:47 +0800
Message-Id: <20220815010349.432313-1-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220812084921.409142-1-haiyue.wang@intel.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: Merge the fix for handling Non-LRU pages into one patch.
    Drop the break_ksm zone device page check.

v2: Add the Non-LRU pages fix with two patches, so that
    'mm: migration: fix the FOLL_GET' can be applied directly
    on linux-5.19 stable branch.

Haiyue Wang (2):
  mm: migration: fix the FOLL_GET failure on following huge page
  mm: fix the handling Non-LRU pages returned by follow_page

 mm/huge_memory.c |  4 ++--
 mm/ksm.c         | 12 +++++++++---
 mm/migrate.c     | 20 +++++++++++++++-----
 3 files changed, 26 insertions(+), 10 deletions(-)

-- 
2.37.2

