Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83654C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 05:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiDHFGr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 01:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiDHFGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:06:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9891F3A70;
        Thu,  7 Apr 2022 22:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25609B82981;
        Fri,  8 Apr 2022 05:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF7CC385A3;
        Fri,  8 Apr 2022 05:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649394269;
        bh=A8E/2qLrfcJDL2srZmto+rQYkeq/2Z44WHf0Pte8Gn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opTuCquPoLFhKikfaXwxfZXnn3CB8WpiInYmzwnDwxiD/0NRe54AiKIGyneeOJuw7
         mIGWp68jNiadbP42ahiXJtFqGZ9sz94iwh0B8Pf0ETW2urFmmBLpLd+jEx94EaORz4
         oLuNkDv2P3q/xwCyLWXi4wez/86iVgBvfL0C6tQU=
Date:   Fri, 8 Apr 2022 07:04:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        andriy.shevchenko@linux.intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v2 04/10] platform/x86/intel/ifs: Load IFS Image
Message-ID: <Yk/CW+a7cyB8NbRd@kroah.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220407191347.9681-5-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407191347.9681-5-jithu.joseph@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 12:13:41PM -0700, Jithu Joseph wrote:
> IFS uses a scan image format that shares the same header as
> microcode updates and deployment approach for these images mirrors
> that of microcode update. Specifically, enable images to be deployed
> relative to a static symlink in /lib/firmware and then load
> into kernel memory via request_firmware().
> 
> The image is specific to a processor family, model and stepping.
> IFS requires that a test image be loaded before any ifs test is
> initiated. Load the image that matches processor signature.
> The IFS image is signed by Intel.
> 
> The IFS image file follows a similar naming convention as used for
> Intel CPU microcode files. The file must be located in the firmware
> directory where the microcode files are placed and named as {family/model
> /stepping}.scan as below:
> 
> /lib/firmware/intel/ifs/{ff-mm-ss}.scan
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/Makefile |  2 +-
>  drivers/platform/x86/intel/ifs/core.c   | 62 ++++++++++++++++++++
>  drivers/platform/x86/intel/ifs/ifs.h    | 15 +++++
>  drivers/platform/x86/intel/ifs/load.c   | 76 +++++++++++++++++++++++++
>  4 files changed, 154 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/platform/x86/intel/ifs/load.c
> 
> diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
> index c44305dff542..b69d026ca9da 100644
> --- a/drivers/platform/x86/intel/ifs/Makefile
> +++ b/drivers/platform/x86/intel/ifs/Makefile
> @@ -1,3 +1,3 @@
>  obj-$(CONFIG_INTEL_IFS)			+= intel_ifs.o
>  
> -intel_ifs-objs				:= core.o
> +intel_ifs-objs				:= core.o load.o
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 87956623208f..716f333a064b 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -2,10 +2,14 @@
>  /* Copyright(c) 2022 Intel Corporation. */
>  
>  #include <linux/module.h>
> +#include <linux/platform_device.h>
>  #include <asm/cpu_device_id.h>
>  
>  #include "ifs.h"
>  
> +struct platform_device *ifs_pdev;
> +struct ifs_binary ifs_binary;

Please no static memory.  Use the driver model properly which does not
want you to do this at all.

You should not need this at all.  If you do, something is wrong as you
are tying the lifecycle of the memory to the code, not to the device.

{sigh}

greg k-h
