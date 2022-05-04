Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13097C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 08:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346492AbiEDIps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 04:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiEDIpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:45:45 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D60A23BCE
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:42:10 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 15359477; Wed,  4 May 2022 10:42:09 +0200 (CEST)
Date:   Wed, 4 May 2022 10:42:07 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Qian Cai <quic_qiancai@quicinc.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <YnI8Xy54M3XQpS0T@8bytes.org>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220502161204.GA22@qian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502161204.GA22@qian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 12:12:04PM -0400, Qian Cai wrote:
> Reverting this series fixed an user-after-free while doing SR-IOV.
> 
>  BUG: KASAN: use-after-free in __lock_acquire

Hrm, okay. I am going exclude this series from my next branch for now
until this has been sorted out.

Alex, I suggest you do the same.

Regards,

	Joerg
