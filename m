Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0616C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 14:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiDFOmC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiDFOld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:41:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E10954B509
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:07:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF58F1424;
        Wed,  6 Apr 2022 04:06:59 -0700 (PDT)
Received: from bogus (unknown [10.57.43.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 929CF3F718;
        Wed,  6 Apr 2022 04:06:58 -0700 (PDT)
Date:   Wed, 6 Apr 2022 12:06:55 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, wangqing <11112896@bbktel.com>
Subject: Re: [PATCH] arch_topology: support parsing cache topology from DT
Message-ID: <20220406110655.iimv6s4godvgfwoq@bogus>
References: <1649236680-4340-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649236680-4340-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 02:18:00AM -0700, Qing Wang wrote:
> From: wangqing <11112896@bbktel.com>
> 
> When ACPI is not enabled, we can parse cache topolopy from DT:
> *		cpu0: cpu@000 {
> *			next-level-cache = <&L2_1>;
> *			L2_1: l2-cache {
> * 				compatible = "cache";
> *				next-level-cache = <&L3_1>;
> * 			};
> *			L3_1: l3-cache {
> * 				compatible = "cache";
> * 			};
> *		};
> *
> *		cpu1: cpu@001 {
> *			next-level-cache = <&L2_1>;
> *		};
> *		cpu2: cpu@002 {
> *			L2_2: l2-cache {
> * 				compatible = "cache";
> *				next-level-cache = <&L3_1>;
> *			};
> *		};
> *
> *		cpu3: cpu@003 {
> *			next-level-cache = <&L2_2>;
> *		};
> cache_topology hold the pointer describing "next-level-cache", 
> it can describe the cache topology of every level.
> 
> Expand the use of llc_sibling when ACPI is not enabled.
>

You seem to have posted this patch as part of the series first. One patch
was rejected and then you post this without any history. It confuses if you
don't provide all the background/history.

Having said that, NACK for this patch as it stands. We have
drivers/base/cacheinfo.c which has all the parsing of cache information.
IIRC we already consider LLC but highlight if anything is particularly
missing. I am unable to follow/understand with you commit message. 

-- 
Regards,
Sudeep
