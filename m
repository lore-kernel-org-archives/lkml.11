Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B64AC4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 21:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiCUVRZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 17:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiCUVRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 17:17:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE922A0473;
        Mon, 21 Mar 2022 14:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647897353; x=1679433353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mGMqNGGnAAv9F4G2///ghFf3QxQGDyzRBcse/JeKnBw=;
  b=WaXlYvQawJCmguCMLjdDFtZsvdwdA758lvEnFgDgtWQX4f6DmvgGfu7F
   kfHkfGbCIk/yZ5LjO9wPoqWvUn2dHQXl9cXplHY61MwWEf0vbE7fetsLv
   6FgGPCC5/R/7NCydOyI9yhUhwFUOdM3FKrQCVcYZ3FsMkptwc1Z8Jv+Gp
   FIiRxlhuONCrrcsmhylw97+thdaXsIOhKsum6aLK7/wZGktR0Zp9wIMxE
   8uvOiqYX2XMxNmM5ayoaX4HXiY6aITI0zdpTTUutciAt5hUpgWpIj59CK
   oEXTpkoFELTy/MWAhddnjSj0U2S5tV4Y60iAgVr43Ifrc5gNpNrpNEyLi
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257369518"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="257369518"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 14:15:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="716644397"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 14:15:52 -0700
Date:   Mon, 21 Mar 2022 14:15:50 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC 08/10] platform/x86/intel/ifs: Add IFS sysfs interface
Message-ID: <YjjrBuVSWqLIoAaq@agluck-desk3.sc.intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <20220301195457.21152-9-jithu.joseph@intel.com>
 <188492dc80c017375da76d444347b1d00c2031f6.camel@intel.com>
 <7b9c788e-21dc-eedc-a1b4-9c6877fa48fe@intel.com>
 <52a16a3eb3f54ec88f7a841baa7000fd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a16a3eb3f54ec88f7a841baa7000fd@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 09:01:03PM +0000, Luck, Tony wrote:
> >> You could just cut to the chase and do: sysfs_eq(buf, "1")
> >
> > Thanks will use this
> 
> $ git grep sysfs_eq
> $
> 
> I don't see this defined (or used) anywhere in the kernel. Is
> it spelled differently from how typed here?

Just to close out this thread ... the function name
that Dan was looking for was sysfs_streq().

-Tony
