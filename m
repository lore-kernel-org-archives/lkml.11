Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF66C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 13:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiGANrG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 09:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiGANqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:46:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A9DD27B32
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:46:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ABC9113E;
        Fri,  1 Jul 2022 06:46:54 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BBDC3F66F;
        Fri,  1 Jul 2022 06:46:52 -0700 (PDT)
Date:   Fri, 1 Jul 2022 14:46:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vincent.guittot@linaro.org, f.fainelli@gmail.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/5] firmware: arm_scmi: Remove deprecated ida_simple_
 calls
Message-ID: <20220701134650.hk4nkzq3xd6utovn@bogus>
References: <20220623124742.2492164-1-cristian.marussi@arm.com>
 <20220623124742.2492164-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623124742.2492164-2-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:47:38PM +0100, Cristian Marussi wrote:
> Remove deprecated calls to ida_simple_get/ida_simple_remove.
> 
 
As you are aware, similar patch is already merged [1].

-- 
Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/c/4ce7e51dc7
