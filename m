Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 13:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbiCaNlk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 09:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiCaNli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:41:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E0965485
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:39:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40E79B820C2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597FBC3410F;
        Thu, 31 Mar 2022 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648733988;
        bh=2AadCGNxCzfaSpTKNEhZbOlEaZXEIT1xpSB/CqupWQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZwQyMEsVJ9vRl+EcpzA34l/77VIPFuoJqeuZ2pd+iik8vPGH1aookspLLZqqX6utY
         Ipcw1t6B6E10sMKURl8xfhKG3HoSQhXTJR4Q6rPGTYhjbIMT1WiXS5v9JyVx4bkmUl
         BnxH9RXNP2n93MC5NkNdvgIBPwsYK9t9fZ0JOB/Q=
Date:   Thu, 31 Mar 2022 15:39:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Haren Myneni <haren@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/vas: use default_groups in kobj_type
Message-ID: <YkWvHRoCk3KM283t@kroah.com>
References: <20220329142552.558339-1-gregkh@linuxfoundation.org>
 <87h77efg8e.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h77efg8e.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:39:45PM +1100, Michael Ellerman wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > There are currently 2 ways to create a set of sysfs files for a
> > kobj_type, through the default_attrs field, and the default_groups
> > field.  Move the pseries vas sysfs code to use default_groups field
> > which has been the preferred way since aa30f47cf666 ("kobject: Add
> > support for default attribute groups to kobj_type") so that we can soon
> > get rid of the obsolete default_attrs field.
> >
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Haren Myneni <haren@linux.ibm.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >
> > Note, I would like to take this through my driver-core tree for 5.18-rc2
> > as this is the last hold-out of the default_attrs field.  It "snuck" in
> > as new code for 5.18-rc1, any objection to me taking it?
> 
> No objection, please take it via your tree.

Thanks, will do!
