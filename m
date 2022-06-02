Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F13C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 20:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbiFBUPP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 16:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiFBUPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:15:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986C21C2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 13:15:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6DBF6182B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 20:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28473C385A5;
        Thu,  2 Jun 2022 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654200910;
        bh=YIVH0p4aoWGInQd4o2kXLa6claUxTJLCw6KPavoyCgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJCsC3Sl0IOdbG2mO+DY8PDGREWgoogPPc4rqryG+7F2xlGbAoV1yxz1zV1kmM6vy
         8todTYSmTAPBr1H7gZL9fzrmN+GiMWsJPYsumRiwOf3iqEpInT9aha1fID0Q7EM+7j
         oE5V5OOBBfOeaMpcZP9GoPL9fCbkU2hkVgNcw7GY=
Date:   Thu, 2 Jun 2022 22:15:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kah.jing.lee@intel.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        tien.sung.ang@intel.com, Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 1/2] drivers: misc: intel_sysid: Add sysid from arch to
 drivers
Message-ID: <YpkaTFywg+GkPElr@kroah.com>
References: <20220602122212.3021232-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602122212.3021232-1-kah.jing.lee@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 08:22:13PM +0800, kah.jing.lee@intel.com wrote:
> From: Kah Jing Lee <kah.jing.lee@intel.com>
> 
> Add sysid driver. The Altera(Intel) Sysid component is generally part of an
> FPGA design. The component can be hotplugged when the FPGA is reconfigured.
> This patch fixes the driver to support the component being hotplugged.
> 
> Usage:
>   cat /sys/bus/platform/devices/soc:base_fpga_region/
> 		soc:base_fpga_region:fpga_pr_region0/[addr.sysid]/sysid/id
>   cat /sys/bus/platform/devices/soc:base_fpga_region/
> 		soc:base_fpga_region:fpga_pr_region0/[addr.sysid]/sysid/timestamp
> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>

Please work with the Intel open source group as there are some internal
Intel requirements that you have not met here in order to be able to
submit a patch for external people to review.  I'll refrain from
reviewing or even considering this to be able to be accepted this until
that happens.

good luck!

greg k-h
