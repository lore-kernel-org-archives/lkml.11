Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E1AC19F28
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 07:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiHCHsc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 03:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiHCHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:48:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2A027169;
        Wed,  3 Aug 2022 00:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93839CE2229;
        Wed,  3 Aug 2022 07:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504A4C433C1;
        Wed,  3 Aug 2022 07:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659512899;
        bh=qdSXnnxizskpZg4WRUguZmVO6f41UwXj9JejJVfJm9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ayqPP/y+3kAfvfVWOm7kH52i6PxOr+AbDyFbqgVir7Cr5qdYtIk+TGAe9KABSW90d
         8dALFca9AGk37YQeL8YoeO+CgrSI3+R0tFOuAMFOUjJIMtCiCeG3DldMZpNsn1fkvP
         tKVJ60G5ZQB3Kjhlxg8s5+EI7kYRVfjxX3ykI8hE=
Date:   Wed, 3 Aug 2022 09:48:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Malani, Prashant" <pmalani@google.com>,
        "bleung@google.com" <bleung@google.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "Jamet, Michael" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: Re: [PATCH] thunderbolt: Supporting wake on DP hot events behind
 TBT/USB4 routers
Message-ID: <YuooQKCYY0spcU2i@kroah.com>
References: <CO1PR11MB48353AD9FD931B1D4AD5646F969C9@CO1PR11MB4835.namprd11.prod.outlook.com>
 <CO1PR11MB48354DBE206824F26EB3D830969C9@CO1PR11MB4835.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB48354DBE206824F26EB3D830969C9@CO1PR11MB4835.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 07:31:30AM +0000, Khandelwal, Rajat wrote:
> 

What did you write here?

confused,

greg k-h
