Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D211C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 01:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344504AbiBHBuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241926AbiBHBdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:33:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81866C061A73
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644284020; x=1675820020;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lCvKr8YSZEJVpbrPbtkoNv3VFQvm3GXDNvJCWJ1cbfQ=;
  b=OVwmuZsXDYNGLFytnYauiH07MhHsAq0IYUsktefUtNAy5gW1i381jA+5
   ikjyYOPptTWU1xERyvFWtXB3Mmf0TYY/WZa3N7lsb+yMHGpBRZQWToWNE
   tMT8sqxCJaaIOZXIU4GVQHS2halvPAFQkFtwQJBzWk909zyss4gDzQuEg
   iNDqkKia7rZWbx+EArtyAprzczYDgn3qMRSNUv+0kbpIvohjwcoMwu0IB
   JIIqaBPh/jG1KB/gEylM4zvnwa+JKhRyUHwWWTQsi/curGZ4eToJj4bNs
   KDFZmTLmv8y5lHrHw36VX5qvrqLTeZeN58c9XmB397gpt22YlIVKyYlhZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="246436875"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="246436875"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:33:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677950229"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 17:33:36 -0800
Message-ID: <40399e95-1ce4-187e-06c1-7cd7b7f4a190@linux.intel.com>
Date:   Tue, 8 Feb 2022 09:32:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] iommu cleanup and refactoring
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 3:10 PM, Lu Baolu wrote:
> Hi,
> 
> The guest pasid and aux-domain related code are dead code in current
> iommu subtree. As we have reached a consensus that all these features
> should be based on the new iommufd framework (which is under active
> development), the first part of this series removes and cleanups all
> the dead code.
> 
> The second part of this series refactors the iommu_domain by moving all
> domain-specific ops from iommu_ops to a new domain_ops. This makes an
> iommu_domain self-contained and represent the abstraction of an I/O
> translation table in the IOMMU subsystem. With different type of
> iommu_domain providing different set of ops, it's easier to support more
> types of I/O translation tables.
> 
> Please help to review and comment.

Thank you all for the great comments. A new version of this series has
been posted.

https://lore.kernel.org/linux-iommu/20220208012559.1121729-1-baolu.lu@linux.intel.com/

Please check whether I missed anything.

Best regards,
baolu
