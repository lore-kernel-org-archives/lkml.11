Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE63C4167D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 07:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244064AbiBGHR5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 02:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbiBGHOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:14:24 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203A9C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:14:24 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 653AF68BEB; Mon,  7 Feb 2022 08:14:20 +0100 (CET)
Date:   Mon, 7 Feb 2022 08:14:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/10] iommu/vt-d: Use an xarray for global
 device_domain_info
Message-ID: <20220207071420.GG23941@lst.de>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com> <20220207064142.1092846-8-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207064142.1092846-8-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> + #define DEVI_IDX(seg, bus, devfn) ((((u16)(seg)) << 16) | PCI_DEVID(bus, devfn))

Please turn this into an real function.
>  /*
> - * Iterate over elements in device_domain_list and call the specified
> + * Iterate over elements in device_domain_array and call the specified
>   * callback @fn against each element.
>   */
>  int for_each_device_domain(int (*fn)(struct device_domain_info *info,
>  				     void *data), void *data)
>  {
>  	struct device_domain_info *info;
> +	unsigned long index;
> +	int ret = 0;
>  
> +	rcu_read_lock();
> +	xa_for_each(&device_domain_array, index, info) {
>  		ret = fn(info, data);
> +		if (ret)
> +			break;
>  	}
> +	rcu_read_unlock();

Can't we just open code this in the caller now?

>  const struct iommu_ops intel_iommu_ops;
> @@ -900,7 +898,8 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u
>  	struct dmar_domain *domain;
>  	int offset, level;
>  
> -	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
> +	info = xa_load(&device_domain_array,
> +		       DEVI_IDX(iommu->segment, bus, devfn));
>  	if (!info || !info->domain) {
>  		pr_info("device [%02x:%02x.%d] not probed\n",
>  			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));

Is there any refcounting or other life time protection for the info
structures?
