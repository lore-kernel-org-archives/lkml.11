Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58D8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 10:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiCIKyt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 05:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiCIKyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:54:47 -0500
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7949C107A80
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:53:45 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 8614B40A55; Wed,  9 Mar 2022 10:53:43 +0000 (GMT)
Date:   Wed, 9 Mar 2022 10:53:43 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     Dmitrii Okunev <xaionaro@fb.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Xiaoyan Zhang <xiaoyan.zhang@intel.com>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [RFC PATCH] platform/x86: Add sysfs interface for Intel TXT
 status
Message-ID: <20220309105343.GA14476@srcf.ucam.org>
References: <1368465884-14779-1-git-send-email-qiaowei.ren@intel.com>
 <1368465884-14779-3-git-send-email-qiaowei.ren@intel.com>
 <20130516160311.GA12299@amd.pavel.ucw.cz>
 <4febd50da7e5007a2797e0f4c969fa5edd0bf725.camel@fb.com>
 <Yg5A4Mupue0V9diu@kroah.com>
 <20220217123753.GA21849@duo.ucw.cz>
 <0cf678e0b01bf421f3db6693a15ac4060501a80a.camel@fb.com>
 <20220222093101.GA23654@amd>
 <YiiD3WM76L3jbMyW@noodles-fedora-PC23Y6EG.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiiD3WM76L3jbMyW@noodles-fedora-PC23Y6EG.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:40:03AM +0000, Jonathan McDowell wrote:

> This module provides read-only access to the Intel TXT (Trusted
> Execution Technology) status registers, allowing userspace to determine
> the status of measured boot and whether the dynamic root of trust for
> measurement (DRTM) has been fully enabled.

So there's the obvious issue that in the event that the system has been 
compromised this information is no longer trustworthy - is this expected 
to just be informative for diagnostic purposes rather than forming any 
part of security policy?

> +	  These registers provide details about the status of the platform's
> +	  measured launch and execution environment, allowing userspace to
> +	  make trust based decisions. See tboot

Mm. This makes it sound like it's expected that userspace make decisions 
based on this, which sounds like a bad plan?

> +/* Shows if TXT has been enabled */
> +static int txt_enabled_show(struct seq_file *m, void *v)
> +{
> +	/* If the BIOS has enabled TXT then the heap base will be set */

Sorry it's not that I want to say "Wait are you trusting that the BIOS 
will do the right thing here" but wait are you trusting that the BIOS 
will do the right thing here? Does setting the heap base guarantee that 
TXT was enabled (and, conversely, are there any scenarios where TXT was 
enabled and the BIOS could have cleared the heap base after a 
measurement event?)

> +/* Shows the 256 bit hash of the public key */
> +static int txt_key_show(struct seq_file *m, void *v)
> +{
> +	seq_printf(m, "%016llx%016llx%016llx%016llx\n",
> +		cpu_to_be64(*(u64 *)(txt_pub_regs + TXT_CR_PUBLIC_KEY)),
> +		cpu_to_be64(*(u64 *)(txt_pub_regs + TXT_CR_PUBLIC_KEY + 8)),
> +		cpu_to_be64(*(u64 *)(txt_pub_regs + TXT_CR_PUBLIC_KEY + 16)),
> +		cpu_to_be64(*(u64 *)(txt_pub_regs + TXT_CR_PUBLIC_KEY + 24)));

What's the expected consumer of this, and what are they expected to do 
with it?

