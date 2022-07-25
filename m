Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5EAC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 14:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiGYOwk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 10:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbiGYOwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:52:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E5301837D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:52:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55C772B;
        Mon, 25 Jul 2022 07:52:34 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.41.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 794413F73D;
        Mon, 25 Jul 2022 07:52:32 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>
Subject: [PATCH v1 0/4] coresight: Reduce duplicated sysfs accessors 
Date:   Mon, 25 Jul 2022 15:52:17 +0100
Message-Id: <20220725145221.517776-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent of this change is to reduce the large number identical of
functions created by macros for sysfs accessors. It's possible to re-use
the same function but pass in the register to access as an argument.
This reduces the size of the coresight modules folder by 244KB.

The first two patches are refactors to simplify and remove some dead
code, and the second two are the changes to use a shared function.

Testing
=======

No changes in any of the outputs:

  cat /sys/bus/coresight/devices/*/mgmt/* > before.txt
  cat /sys/bus/coresight/devices/*/mgmt/* > after.txt
  diff before.txt after.txt

With the following modules loaded:

  ls /sys/bus/coresight/devices/
  etm0  etm2  funnel0  funnel2  replicator0  tmc_etf0  tmc_etf2  tpiu0
  etm1  etm3  funnel1  funnel3  stm0         tmc_etf1  tmc_etr0

James Clark (4):
  coresight: Remove unused function parameter
  coresight: Simplify sysfs accessors by using csdev_access abstraction
  coresight: Re-use same function for similar sysfs register accessors
  coresight: cti-sysfs: Re-use same functions for similar sysfs register
    accessors

 drivers/hwtracing/coresight/coresight-catu.c  |  27 +--
 drivers/hwtracing/coresight/coresight-core.c  |  14 ++
 .../hwtracing/coresight/coresight-cti-sysfs.c | 213 +++++++-----------
 drivers/hwtracing/coresight/coresight-etb10.c |  28 +--
 .../coresight/coresight-etm3x-sysfs.c         |  34 +--
 drivers/hwtracing/coresight/coresight-priv.h  |  48 ++--
 .../coresight/coresight-replicator.c          |  10 +-
 drivers/hwtracing/coresight/coresight-stm.c   |  40 +---
 .../hwtracing/coresight/coresight-tmc-core.c  |  48 ++--
 include/linux/coresight.h                     |  18 ++
 10 files changed, 196 insertions(+), 284 deletions(-)

-- 
2.28.0

