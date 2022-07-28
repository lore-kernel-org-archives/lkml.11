Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC70C04A68
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jul 2022 07:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiG1H5Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jul 2022 03:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiG1H5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:57:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C47261734
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E64A061B77
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF143C433B5;
        Thu, 28 Jul 2022 07:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658995039;
        bh=sVC6R36w9q8CDkln0Ao6dfLC7vtO3DXrKYaDh8h3Nkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLPXiL68T7jk9Y8z7tguQOrvg/Z7hbirEaOMqZ5EMUHHHkHscPUEc8TPHY1S4tqbi
         OZ7wFZ/MapFI13B2I30GMMT2axyNSq2alk+RlnhRUHMM9gAw46ChbC/uoqJWMtrCqz
         YOLPKQi4ZQpKDv/G9KFwaQVpcXEcKN2mX+lTREgY=
Date:   Thu, 28 Jul 2022 09:57:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Zhou@kroah.com,
        Furong <furong.zhou@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/3] drivers: misc: intel_sysid: Add sysid from arch
 to drivers
Message-ID: <YuJBXLtLYywGsXDu@kroah.com>
References: <20220721123017.416438-1-kah.jing.lee@intel.com>
 <20220721123149.416618-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721123149.416618-1-kah.jing.lee@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 08:31:50PM +0800, kah.jing.lee@intel.com wrote:
> From: Kah Jing Lee <kah.jing.lee@intel.com>
> 
> Add new sysid driver. The Altera(Intel) Sysid component is generally part
> of an FPGA design. The component can be hotplugged when the FPGA is
> reconfigured. This driver support the component being hotplugged.
> The sysid driver stores unique 32-bit id value which is similar to a
> check-sum value; different components, different configuration options,
> or both, can be configured to produce different id values. Timestamp field
> is the unique 32-bit value that is based on the system generation time.

I really do not understand what this driver does at all, sorry.  It only
exports 2 sysfs files.  Who will use those sysfs files?  What are they
for?  Why is a driver needed at all as all you are doing is reading 2
memory values from the device, right?  Why is the kernel responsible for
doing the data conversion logic and not userspace?

> There are two basic ways to use the system ID core:
> - Verify the system ID before downloading new software to a system. This
> method can be used by software development tools, before downloading a
> program to a target hardware system, if the program is compiled for
> different hardware.

verify it how?  This is just a random value that we have no idea how to
treat it.

> - Check system ID after reset. If a program is running on hardware other
> than the expected Platform Designer system, the program may fail to
> function altogether. If the program does not crash, it can behave
> erroneously in subtle ways that are difficult to debug. To protect against
> this case, a program can compare the expected system ID against the system
> ID core, and report an error if they do not match.

Where are these ids listed to be able to verify anything?

What userspace tools use this new driver?

thanks,

greg k-h
