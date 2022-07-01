Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B303C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 11:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiGALuW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 07:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbiGALuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:50:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC83F7B358;
        Fri,  1 Jul 2022 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656676218; x=1688212218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uh1R6VOnk1/6zpZqBN13uSW7N3n6GTHWBfXKI429EXs=;
  b=SqDGBpjw7EiuIUcVm9zaMdqrd6Xg8PFrG2iEdCCtPynUsh/R0aDZHjgH
   scJt8y247A5esSY4u620IyZUCb82NWjSC5+2WtWWY6ML6N3Yda4AbsYWh
   7v3VRRaz1GPyS8WOjV6JzAEGvDyIrabI/xODnUSMWDHQ/zV5BMIgIi/iD
   3KazdqZFgoWA0roIOMcs4nELUYXvOe5phQ9E6CBn+3HMcUDix4cC5pYyh
   yZv2AvGTl4Uk8VxlwgNhsfP0qFxvCZHluBX/Fq0kDTmW6Umxi955j4snA
   FtL2irVkJCZv7/CFrwIkEBUEaIKIo9jbafp9BFI9kCJzn5w1C+ljuyVwo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="271405541"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="271405541"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 04:50:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="694486539"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 04:50:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o7FA5-000zJx-L8;
        Fri, 01 Jul 2022 14:50:13 +0300
Date:   Fri, 1 Jul 2022 14:50:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/1] platform/x86: asus-wireless: Replace open coded
 acpi_match_device()
Message-ID: <Yr7fdUGNQFQEdoRh@smile.fi.intel.com>
References: <20220630193234.3499-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630193234.3499-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 10:32:34PM +0300, Andy Shevchenko wrote:
> Replace open coded acpi_match_device() in asus_wireless_add().

Discard this, a last minute change that makes it not buildable.

-- 
With Best Regards,
Andy Shevchenko


