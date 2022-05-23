Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F9AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 10:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiEWKBu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 06:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiEWKBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:01:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35C12DEC4;
        Mon, 23 May 2022 03:01:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95EF811FB;
        Mon, 23 May 2022 03:01:43 -0700 (PDT)
Received: from bogus (unknown [10.57.66.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F6683F73D;
        Mon, 23 May 2022 03:01:42 -0700 (PDT)
Date:   Mon, 23 May 2022 11:01:36 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: fix typos in comments
Message-ID: <20220523100136.y62iygwk66avsh2y@bogus>
References: <20220521111145.81697-48-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-48-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 01:10:58PM +0200, Julia Lawall wrote:
> Spelling mistakes (triple letters) in comments.
> Detected with the help of Coccinelle.
>

I see lot of similar patches and assuming you plan to get them in one go, so:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Please let me know if you want me to take it.

-- 
Regards,
Sudeep
