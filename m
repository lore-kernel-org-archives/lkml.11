Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93870C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 13:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349768AbiETNYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 09:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbiETNYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:24:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7AD149D83
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653053059; x=1684589059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tz0oHsiYFTbKwA51WeEhnagqrhxFjDvDojd+nOmi44w=;
  b=OTiM34qvWhfpIHcFd/VO0fIeT4EWsJQ2rdjJfhME8PL2YHE8bv/c1q+I
   963rSxW/LPQBjAHLCi6MxscbpzEI0pVCsGiSFCaLb20E3SLKb8ld4IQ5b
   Dkn/Qp+fO4Rd1+PH0OwQ9hahywvvy1VvLyevbs9k0IIQ44q4jt3O/BIEs
   Te9XsIsen1prmMv/Zbm6TDBucU4iUjZ9/8DsNkLDyKOMMtkCTpK9RqZHE
   BtVl/RRqKX3WsPGUWrw2w2YhU4uGbio8+DYSWJERIBTcuxFfbbATJjt8T
   fDlj+i481l9T2GEPn5Bx/IOG9FntP8RDq906efVrI0rhXM7zkwOoFeIdz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="335661005"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="335661005"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:24:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="715530792"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.38.124])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:24:17 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] perf inject: Minor improvements
Date:   Fri, 20 May 2022 16:23:59 +0300
Message-Id: <20220520132404.25853-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are patches for 2 minor improvements for perf inject:
1. Keep some features sections from input file
2. Keep a copy of kcore_dir


Adrian Hunter (5):
      perf header: Add ability to keep feature sections
      libperf: Add preadn()
      perf inject: Keep some features sections from input file
      perf data: Add has_kcore_dir()
      perf inject: Keep a copy of kcore_dir

 tools/lib/perf/include/internal/lib.h |   2 +
 tools/lib/perf/lib.c                  |  20 +++++
 tools/perf/builtin-inject.c           | 162 +++++++++++++++++++++++++++++++++-
 tools/perf/util/data.c                |  14 +++
 tools/perf/util/data.h                |   1 +
 tools/perf/util/header.c              |  62 +++++++++++--
 tools/perf/util/header.h              |  15 ++++
 7 files changed, 264 insertions(+), 12 deletions(-)


Regards
Adrian
