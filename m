Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7CAC43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 15:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiGAPFm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 11:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiGAPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:05:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F373218E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:05:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1667B113E;
        Fri,  1 Jul 2022 08:05:38 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07BE93F66F;
        Fri,  1 Jul 2022 08:05:35 -0700 (PDT)
Date:   Fri, 1 Jul 2022 16:05:29 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, daniel.lezcano@linaro.org,
        tarek.el-sherbiny@arm.com, adrian.slatineanu@arm.com,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        wbartczak@marvell.com
Subject: Re: [PATCH v3 5/9] firmware: arm_scmi: Make use of FastChannels
 configurable
Message-ID: <Yr8NOegCv27VCZOd@e120937-lin>
References: <20220627123038.1427067-1-cristian.marussi@arm.com>
 <20220627123038.1427067-6-cristian.marussi@arm.com>
 <20220701140307.upgfn4qpxhl63syg@bogus>
 <Yr8GsvW+cnf3PkSG@e120937-lin>
 <20220701145508.xw3zbhldi7lvcwgd@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701145508.xw3zbhldi7lvcwgd@bogus>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 03:55:08PM +0100, Sudeep Holla wrote:
> On Fri, Jul 01, 2022 at 03:47:20PM +0100, Cristian Marussi wrote:
> 
> [...]
> 
> > ... regarding why, I am using personally this indeed for testing with or
> > without FCs without having to change the installed FW blob, BUT the reason
> > for upstreaming such an option is that FC support is indeed optional by the
> > spec so I thought it would have been acceptabel that you could want to
> > configure a platform NOT to use them even though the FW implementation you
> > are using, maybe across multiple platforms, supports it.
> 
> Yes it is optional. But we use only if F/W advertises that it is available,
> so no harm if it is not implemented right ? I don't believe it will save
> space in the way config is used and I don't want to push all the code
> under the config too.

What I meant was to be able to use the same FW blob_X with valid and
advertised FCs support on multiple platforms, but having the possibility
to configure some of these not to use it even if advertised as
available. Indeed there is no space saving at all that was ot the idea.

Thanks
Cristian
