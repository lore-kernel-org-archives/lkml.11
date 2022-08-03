Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359BFC19F28
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 07:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiHCHsA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 03:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiHCHr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:47:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2D21A07A;
        Wed,  3 Aug 2022 00:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B8D6B82187;
        Wed,  3 Aug 2022 07:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976C6C433D6;
        Wed,  3 Aug 2022 07:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659512875;
        bh=w/71fG1abgktuJYm6T6JkSMs3A5BPKoguVtaSQY4iHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rgDf+fC9OBKwhBPT01DqfrwybFUB66bcBsshP4R4fUKkIfdx5doozBLnMCGzVrHDM
         8PovmvoI+JbLMk4lO7qzSol1jXMPck8/Mq1CovwbiQ/XXalGh6NJDdzGZTu39b0EKr
         WBnNzyjmIkd9SvevcPTXRLclvM+E6OSNlh/VQ6e0=
Date:   Wed, 3 Aug 2022 09:47:52 +0200
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
Message-ID: <YuooKOEjLcTUE1F7@kroah.com>
References: <CO1PR11MB48353AD9FD931B1D4AD5646F969C9@CO1PR11MB4835.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB48353AD9FD931B1D4AD5646F969C9@CO1PR11MB4835.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


http://daringfireball.net/2007/07/on_top

On Wed, Aug 03, 2022 at 07:29:36AM +0000, Khandelwal, Rajat wrote:
> +Abhijeet
> @Benson Leung @Malani, Prashant Please provide your comments. 


