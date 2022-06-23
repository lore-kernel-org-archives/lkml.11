Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CED9C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 11:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiFWLdX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 07:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiFWLdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:33:23 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD14713F26
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:33:21 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F0CE44D2; Thu, 23 Jun 2022 13:33:19 +0200 (CEST)
Date:   Thu, 23 Jun 2022 13:33:18 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@lst.de, john.garry@huawei.com
Subject: Re: [PATCH v2] iommu/dma: Add config for PCI SAC address trick
Message-ID: <YrRPfhXvdPo0Y6Cx@8bytes.org>
References: <3f06994f9f370f9d35b2630ab75171ecd2065621.1654782107.git.robin.murphy@arm.com>
 <YrMSJ6AGwn3PxSIH@8bytes.org>
 <b9439692-c72b-b856-c7c0-e60a863f3e74@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9439692-c72b-b856-c7c0-e60a863f3e74@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 02:12:39PM +0100, Robin Murphy wrote:
> Thanks for your bravery!

It already starts, with that patch I am getting:

	xhci_hcd 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000f address=0xff00ffffffefe000 flags=0x0000]

In my kernel log. The device is an AMD XHCI controller and seems to
funciton normally after boot. The message disappears with
iommu.forcedac=0.

Need to look more into that...

