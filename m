Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679EBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 20:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355064AbiDZUmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiDZUl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A848B7484C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42C3F61159
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105F8C385A4;
        Tue, 26 Apr 2022 20:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651005529;
        bh=7FM2Cl7AYC/kifHZh+3Yf++v1gAZu2HGgYiMvm091PM=;
        h=From:To:Cc:Subject:Date:From;
        b=NazlHfNpSvgyX+SbULKpToTFyGeXYPFyIMsGsOw0k4k5foImoKxEh/1s+kyiY/TQ3
         lcC0ZW7RJn6eBepwpRHydi2VOANXlAyAm0zvUWh5mngliAz+jqKcZtIee5VmRINhaf
         T4IK7klTBVVzp9Pl7P6TZ03Klu8iZmCmr54zGZfUTpWH9lSvMpjZqUf32Kld3oFZRL
         xoMnCxhm7dm8ASpLW/7QhI2cH/LT8h5h2KYQYHnR9PYsuQ0CG6LqENNBnFGZUY1xrO
         zkjbzHVe5O0d41z/xTqP8kGC0yhF6CRdRcBjO3Fw/Vsp2spdP/T28oVu7A0gw9ZBkH
         hP65n/n7Bp54g==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/4] mm/damon: allow users know which monitoring ops are available
Date:   Tue, 26 Apr 2022 20:38:39 +0000
Message-Id: <20220426203843.45238-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

DAMON users can configure it for vaious address spaces including virtual
address spaces and the physical address space by setting its monitoring
operations set with appropriate one for their purpose.  However, there
is no celan and simple way to know exactly which monitoring operations
sets are available on the currently running kernel.  This patchset adds
functions for the purpose on DAMON's kernel API
('damon_is_registered_ops()') and sysfs interface ('avail_operations'
file under each context directory).

SeongJae Park (4):
  mm/damon/core: add a function for damon_operations registration checks
  mm/damon/sysfs: add a file for listing available monitoring ops
  selftets/damon/sysfs: test existence and permission of
    avail_operations
  Docs/{ABI,admin-guide}/damon: document 'avail_operations' sysfs file

 .../ABI/testing/sysfs-kernel-mm-damon         | 10 +++++++-
 Documentation/admin-guide/mm/damon/usage.rst  | 18 +++++++++-----
 include/linux/damon.h                         |  1 +
 mm/damon/core.c                               | 24 ++++++++++++++++---
 mm/damon/sysfs.c                              | 19 +++++++++++++++
 tools/testing/selftests/damon/sysfs.sh        |  1 +
 6 files changed, 63 insertions(+), 10 deletions(-)

-- 
2.25.1

