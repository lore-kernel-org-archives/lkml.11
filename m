Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169CFC32793
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 23:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiHWXpf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 19:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiHWXp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:45:29 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7998A6FB;
        Tue, 23 Aug 2022 16:45:27 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f4so11731454pgc.12;
        Tue, 23 Aug 2022 16:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc;
        bh=8UO1wGihVQ8kGhkOFqHrGxvl0WX3n5u+/PNd+s9miG4=;
        b=Kf/bPhzyGLBmL3jMqyoAS1wVdm0HbkKsBxknTWHyipKk1/Nwbsnkjx331Ne0JBRB1Z
         MyFkyd7yAasunIGco2idYhnfjVqDntfJCO3BbptWb7lwr73JnW0JWysCDFTWWhyY5S8F
         i1GNQXvdL7Bnu4N2EdVgAcqIZ5dxdWjFgZjcxhjKXfNV8e8DNekkhBetd0pujeqUpQb5
         vvoILcm3q0qQ2YURqwseBEYFMEae8tjkz5lz5mBi9Y8uW40GIyXMnaUA8Wmbi8FS4lol
         +oJnVgLBWqO4vHynvSIY/0ACCmssGZHa5Z7aZ6W7b7r3n7Nus07w9e/jYvwIsxPdHCkw
         d8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc;
        bh=8UO1wGihVQ8kGhkOFqHrGxvl0WX3n5u+/PNd+s9miG4=;
        b=sCOJI8O9mMgO4XXHoaOB5nRmrpJBkha43av8D6YrW+vV5ux9G+hMFZpQ3WXd4y9qVe
         sE0cPR1G4KZyUMXQ5PxZevfByGZS1tFQ4GGUowKDrnluh5h9/LCpgwxUisnTvCQhZoXc
         kKbKx2SQsRfgINFl4j6kKE4NJATasBFgqCPhQgXgL+hemaqxUdCJdlQoDM8nK8tclinM
         LDt8d6QNAaKj6UOSMUGdUC5SJIASE4owVAgtJ985Jm3z7NpCF7tsBl+/X0HnoF4/qicS
         8E29U32IcvkDOH7NDwCaW0DYxFQqLm8oQfuceYASuAS4sczhyb411rpuQolCHxYpQJFz
         Szsw==
X-Gm-Message-State: ACgBeo0SK9wlFKTX7VEHSwAKRssBW4QcO7RsRF4mnF6EWtheF+/kDO75
        sqPZdDYyH5eKIdMdgtmQgL2nAQ3Cn4Y=
X-Google-Smtp-Source: AA6agR4wsWBfS/h8Oqcln35rb24DFeeWRbkA2yf6gm3M2Ld7LHKc9n7NbLPaM+69QilFxSOaoe50WQ==
X-Received: by 2002:a05:6a00:14c7:b0:52e:efb7:bd05 with SMTP id w7-20020a056a0014c700b0052eefb7bd05mr26749780pfu.24.1661298326786;
        Tue, 23 Aug 2022 16:45:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:90fa])
        by smtp.gmail.com with ESMTPSA id 16-20020a621810000000b00536bef77afasm4301385pfy.31.2022.08.23.16.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 16:45:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 Aug 2022 13:45:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v6.0-rc2
Message-ID: <YwVmlMzNMS5ym9JI@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.0-rc2-fixes

for you to fetch changes up to 763f4fb76e24959c370cdaa889b2492ba6175580:

  cgroup: Fix race condition at rebind_subsystems() (2022-08-23 08:11:06 -1000)

----------------------------------------------------------------
cgroup fixes for v6.0-rc2

Contains fixes for the following issues:

* psi data structure was changed to be allocated dynamically but it wasn't
  being cleared leading to reporting garbage values and triggering spurious
  oom kills.

* A deadlock involving cpuset and cpu hotplug.

* When a controller is moved across cgroup hierarchies, css->rstat_css_node
  didn't get RCU drained properly from the previous list.

----------------------------------------------------------------
Hao Jia (3):
      sched/psi: Zero the memory of struct psi_group
      sched/psi: Remove unused parameter nbytes of psi_trigger_create()
      sched/psi: Remove redundant cgroup_psi() when !CONFIG_CGROUPS

Jing-Ting Wu (1):
      cgroup: Fix race condition at rebind_subsystems()

Tejun Heo (1):
      cgroup: Fix threadgroup_rwsem <-> cpus_read_lock() deadlock

 include/linux/cgroup.h |  5 ----
 include/linux/psi.h    |  2 +-
 kernel/cgroup/cgroup.c | 80 +++++++++++++++++++++++++++++++++++---------------
 kernel/cgroup/cpuset.c |  3 +-
 kernel/sched/psi.c     | 10 ++-----
 5 files changed, 61 insertions(+), 39 deletions(-)
