Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B20C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 13:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380564AbiEMNHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 09:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354913AbiEMNHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:07:49 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A621B795
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:07:48 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E597D4D2; Fri, 13 May 2022 15:07:46 +0200 (CEST)
Date:   Fri, 13 May 2022 15:07:45 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        vasant.hegde@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH v2] iommu/amd: Set translation valid bit only when IO
 page tables are in used
Message-ID: <Yn5YIfzmerwAM30M@8bytes.org>
References: <20220509074815.11881-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509074815.11881-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 02:48:15AM -0500, Suravee Suthikulpanit wrote:
> On AMD system with SNP enabled, IOMMU hardware checks the host translation
> valid (TV) and guest translation valid (GV) bits in the device
> table entry (DTE) before accessing the corresponded page tables.
> 
> However, current IOMMU driver sets the TV bit for all devices
> regardless of whether the host page table is in used.
> This results in ILLEGAL_DEV_TABLE_ENTRY event for devices, which
> do not the host page table root pointer set up.

Hmm, this sound weird. In the early AMD IOMMUs it was recommended to set
TV=1 and V=1 and the rest to 0 to block all DMA from a device.

I wonder how this triggers ILLEGAL_DEV_TABLE_ENTRY errors now. It is
(was?) legal to set V=1 TV=1, mode=0 and leave the page-table empty.
When then IW=0 and IR=0, DMA is blocked. From what I remember this is a
valid setting in a DTE. Do you have an example DTE which triggers this
error message?

Regards,

	Joerg

