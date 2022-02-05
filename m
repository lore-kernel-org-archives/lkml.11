Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BAEC433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Feb 2022 03:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378841AbiBEDKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 22:10:35 -0500
Received: from mail.hallyn.com ([178.63.66.53]:35424 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233090AbiBEDKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 22:10:33 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 8FFA97E4; Fri,  4 Feb 2022 21:10:32 -0600 (CST)
Date:   Fri, 4 Feb 2022 21:10:32 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     James Morris <jmorris@namei.org>
Cc:     "Andrew G. Morgan" <morgan@kernel.org>,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] proc: add SecBits field to /proc/<PID>/status
Message-ID: <20220205031032.GA14228@mail.hallyn.com>
References: <20220131051558.77127-1-morgan@kernel.org>
 <d3fc9d9-d99e-a5ab-10a4-7cc60c97e1e@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3fc9d9-d99e-a5ab-10a4-7cc60c97e1e@namei.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 04:32:00AM +1100, James Morris wrote:
> On Sun, 30 Jan 2022, Andrew G. Morgan wrote:
> 
> > Securebits strongly influence the way Capabilities work for a process,
> > make them visible in the proc status files.
> 
> My concern is that this might break some existing userspace code which 
> parses the status file.

I don't think anyone should be using that file expecting the fields
in a certain order.  No 'grep "^VmRSS:" /proc/self/status' type of
use is going to be broken by this patch.  Do you have something else
in mind?

-serge
