Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CCEC00140
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 16:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbiHLQ7m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 12:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbiHLQ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:59:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395EEB0B20;
        Fri, 12 Aug 2022 09:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5C17B82469;
        Fri, 12 Aug 2022 16:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADF31C433C1;
        Fri, 12 Aug 2022 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660323573;
        bh=UTKXm22gxGKOxQwXMb2+WzZLLlwtMaey0B1673Ha0c0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M0+xi+wW9kr/9EALHN5PaRgaWI682cL1D0MjZjpUvSKizAEdNmkR+cEMSClYXheBM
         t33+JlyYKkYUWG3uxGRuCzLLLCpXGjUHmy4CJWwEQqlakX79MssnxmFy+zyfM42nkG
         oWxvd69utb3t42NpTAFv7i0Eea7m4D8tfK2nKYFURxyQ11bbceYuiDi10kspiu6bpV
         liBqp36MlEcvcJrf14d5vfWlbDwPVIy9sWYG+CmYFH6cz6pI69hQk5JfIPV0/lkHiZ
         WGcd/21JOEROn9mNDzeIrjWKAxSnGcfpkQKJfq4wEduuUnOsl0Ukdolzl4VxYDXYOj
         Msy4NdT8RHvKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96D06C43142;
        Fri, 12 Aug 2022 16:59:33 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: fatures, fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220812114250-mutt-send-email-mst@kernel.org>
References: <20220812114250-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220812114250-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 93e530d2a1c4c0fcce45e01ae6c5c6287a08d3e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a53e17accce9d310d2e522dfc701d8da7ccfa65
Message-Id: <166032357360.14629.10068636645471683682.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Aug 2022 16:59:33 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alvaro.karsz@solid-run.com, colin.i.king@gmail.com,
        colin.king@intel.com, dan.carpenter@oracle.com, david@redhat.com,
        elic@nvidia.com, eperezma@redhat.com, gautam.dawar@xilinx.com,
        gshan@redhat.com, hdegoede@redhat.com, hulkci@huawei.com,
        jasowang@redhat.com, jiaming@nfschina.com,
        kangjie.xu@linux.alibaba.com, lingshan.zhu@intel.com,
        liubo03@inspur.com, michael.christie@oracle.com, mst@redhat.com,
        pankaj.gupta@amd.com, peng.fan@nxp.com, quic_mingxue@quicinc.com,
        robin.murphy@arm.com, sgarzare@redhat.com, suwan.kim027@gmail.com,
        syoshida@redhat.com, xieyongji@bytedance.com,
        xuanzhuo@linux.alibaba.com, xuqiang36@huawei.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Aug 2022 11:42:50 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a53e17accce9d310d2e522dfc701d8da7ccfa65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
