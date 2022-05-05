Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDC6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 09:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352198AbiEEJUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 05:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiEEJUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:20:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 930EF2E9ED
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:17:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0786E1042;
        Thu,  5 May 2022 02:17:00 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA38F3FA27;
        Thu,  5 May 2022 02:16:58 -0700 (PDT)
Date:   Thu, 5 May 2022 10:16:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4] arch_topology: Trace the update thermal pressure
Message-ID: <20220505091656.2ryeyy5c7wy73uqh@bogus>
References: <20220427080806.1906-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427080806.1906-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:08:06AM +0100, Lukasz Luba wrote:
> Add trace event to capture the moment of the call for updating the thermal
> pressure value. It's helpful to investigate how often those events occur
> in a system dealing with throttling. This trace event is needed since the
> old 'cdev_update' might not be used by some drivers.
> 
> The old 'cdev_update' trace event only provides a cooling state
> value: [0, n]. That state value then needs additional tools to translate
> it: state -> freq -> capacity -> thermal pressure. This new trace event
> just stores proper thermal pressure value in the trace buffer, no need
> for additional logic. This is helpful for cooperation when someone can
> simply sends to the list the trace buffer output from the platform (no
> need from additional information from other subsystems).
> 
> There are also platforms which due to some design reasons don't use
> cooling devices and thus don't trigger old 'cdev_update' trace event.
> They are also important and measuring latency for the thermal signal
> raising/decaying characteristics is in scope. This new trace event
> would cover them as well.
> 
> We already have a trace point 'pelt_thermal_tp' which after a change to
> trace event can be paired with this new 'thermal_pressure_update' and
> derive more insight what is going on in the system under thermal pressure
> (and why).
> 

Sorry for missing this, looks good to me.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
