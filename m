Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482CCC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 23:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiBIX2l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 18:28:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiBIX2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:28:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9B6E057C0E;
        Wed,  9 Feb 2022 15:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VyiuDl3IpexkLMiuqnAvBqtY58D0U7tUwB8UiSDeVcI=; b=grTIEYFbVAFWjguDBt19JuKsUw
        tDr9AL5CAGAp6o7VsbQCgRCFKHcsYQB6CtqrfKmQvfg+I2hyJlttajcvnSVItWRpnz7k71T0Qg2kI
        RbFoZLzQKCKEEh5h3HLSkyMR6yz+AFhljmGoto9uyBNbg35xa04D7Zs1gaoVbSRpU0gn07JAsa11D
        vZ9+Ov/aENr8JphK3j6B+t6tcRXVg+IJzmL+8cX1fxzhnsb9Zf6QDqqlFBj8lpiR1xah5drLUVCuf
        0ICXACvFPzmd+dTstrbDNOVsLbVs9tuxGEingVY/XHSqX+OxzYFx9mkmylqRlGuwp8zPAZ8OO3FfM
        YIXLeH9w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHwNW-0022x2-Bi; Wed, 09 Feb 2022 23:28:02 +0000
Date:   Wed, 9 Feb 2022 15:28:02 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zhen Ni <nizhen@uniontech.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched: move uclamp_util sysctls to core.c
Message-ID: <YgROAtIdjfUXO5lJ@bombadil.infradead.org>
References: <20220209085730.22470-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209085730.22470-1-nizhen@uniontech.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 04:57:30PM +0800, Zhen Ni wrote:
> move uclamp_util sysctls to core.c and use the new
> register_sysctl_init() to register the sysctl interface.
> 
> Signed-off-by: Zhen Ni <nizhen@uniontech.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
