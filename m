Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC458C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 06:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353899AbiCPGb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 02:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351336AbiCPGbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:31:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D3D5A0AC;
        Tue, 15 Mar 2022 23:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647412210; x=1678948210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s+JdLeo9XMuVFw/gFxTEj/scZqStb/MDbqCMBDStDII=;
  b=a+j6wr6QR8M+R46PVv2etzKd0pmjbyP8SFer1xBr+plXvuB59DLxxupt
   Nd77DNG0FZQ7PnlrHScLRoFr8b1k6bs+P2Cbhoy+BgPySJ8abEKUX7dXq
   q5IODDtye97MF2BXrPTd2DWTYCzbtVgQNsfxLAOBMnLH5nILDU8SG8Kqe
   DuJL+Z379kQWV517yic8BAiZjjjKmDMW7rtUhgZKqHX5lYXuNeAtSvhPP
   +3TNMhqTyvxT3FFxeeq0Vrz/npS1/5jLxfcyq0GKA8HX/BhH8NYKugRO6
   cdnQTV03MEgg76BEW1PczHsS1JvVA3Awjq/AAVRD3NSZPTpQIoeS0WhF0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256456919"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="256456919"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 23:30:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="646526563"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 23:30:07 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 16 Mar 2022 08:30:04 +0200
Date:   Wed, 16 Mar 2022 08:30:04 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] thunderbolt: Automatically authorize PCIe tunnels when
 IOMMU is active
Message-ID: <YjGD7N++F+ioISHb@lahna>
References: <20220315213008.5357-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315213008.5357-1-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Tue, Mar 15, 2022 at 04:30:08PM -0500, Mario Limonciello wrote:
> Historically TBT3 in Linux used "Thunderbolt security levels" as a primary
> means of "security" against DMA attacks. This mean that users would need to
> ack any device plugged in via userspace.  In ~2018 machines started to use
> the IOMMU for protection, but instead of dropping security levels a
> convoluted flow was introduced:
> * User hotplugs device
> * Driver discovers supported tunnels
> * Driver emits a uevent to userspace that a PCIe tunnel is present
> * Userspace reads 'iommu_dma_protection' attribute (which currently
>   indicates an Intel IOMMU is present and was enabled pre-boot not that
>   it's active "now")
> * Based on that value userspace then authorizes automatically or prompts
>   the user like how security level based support worked.

There are legitimate reasons to disable PCIe tunneling even if the IOMMU
bits are in place. The ACPI _OSC allows the boot firmware to do so and
our "security levels" allows the userspace policy to do the same. I
would not like to change that unless absolutely necessary.
