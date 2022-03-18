Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321EFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 15:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiCRPlM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 11:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbiCRPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:41:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E8321D2513
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:39:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BF4E1515;
        Fri, 18 Mar 2022 08:39:52 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B81A03F7D7;
        Fri, 18 Mar 2022 08:39:50 -0700 (PDT)
Date:   Fri, 18 Mar 2022 15:39:40 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH 07/16] debugfs: Add signed versions of
 debugfs_create_u32/64 helpers
Message-ID: <YjSnvKV7dElpzTcd@e120937-lin>
References: <20220227205608.30812-1-cristian.marussi@arm.com>
 <20220227205608.30812-8-cristian.marussi@arm.com>
 <YjSHXJZAlntzmyKZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjSHXJZAlntzmyKZ@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 02:21:32PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Feb 27, 2022 at 08:55:59PM +0000, Cristian Marussi wrote:
> > Add a few helpers to deal with signed values integers; built on existing
> > debugfs internal helpers as the existing unsigned functions already do.
> > 
> > Make the simple_attr_write() internal helper detect the sign of the
> > requested set operation from the related format string: this is needed
> > to be able to properly parse negatively signed input strings.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---

Hi Greg,

thanks for the feedback.

> > Note that in the rest of the series I do NOT need the s64 WRITE/SET
> > operations, that required the more invasive simple_attr_write() change,
> > but it seemed odd to implement a get only debug_create_s32/64 API.
> 
> Let's wait to add them when we have a need for them with a in-kernel
> user.  Otherwise I'll just end up removing them eventually when I sweep
> for "is this used" cleanups.
> 

Ok, so just to double check what I understood(or not), I'll leave out the
setters ops and implement instead the debufs_create_s32/s64 with only RO
fops support, right ?

Thanks,
Cristian
