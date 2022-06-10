Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23D5C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 05:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244898AbiFJFpc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 01:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiFJFp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:45:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E067F245AE;
        Thu,  9 Jun 2022 22:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D9B4B830A7;
        Fri, 10 Jun 2022 05:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC190C3411B;
        Fri, 10 Jun 2022 05:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654839925;
        bh=1CUCflqyQ5OvcBwT12upAn5jk64F2GggywWZMTmX+sc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HryEewmp3Cy0HEInxqtqog3JfkcOk+1JqoW6/HFN2ZUY2nxsbKp+StQqUEE3xTBq6
         NqXWWfc0LE1Fp+aXozdeNy3a7gqTEMwe44d0hKulKj+CfgXIoEW61gRZfF96+t4zvl
         UHphClI1QFsKYciO/fSxf+BsXfX7n+MtKMiP6J57GnF3cuonUKRM60GpJFvGX7ARoR
         Us8LSME+lFf69zaRfH5+SBqcfGvRKc416CMaJfXCq4+0RMjhdRGCPX+s8sFNZRPscE
         xG49FDKIrFfdBWgUOdjTpm8+4Hjy86n4S+B93tzdtoUQLfsk6w+UeinXgG4E3+2aX3
         TjmjuMWsdJRDg==
Date:   Thu, 9 Jun 2022 22:45:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v1 1/5] ptp_ocp: use dev_err_probe()
Message-ID: <20220609224523.78b6a6e6@kernel.org>
In-Reply-To: <20220608120358.81147-2-andriy.shevchenko@linux.intel.com>
References: <20220608120358.81147-1-andriy.shevchenko@linux.intel.com>
        <20220608120358.81147-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Jun 2022 15:03:54 +0300 Andy Shevchenko wrote:
> Simplify the error path in ->probe() and unify message format a bit
> by using dev_err_probe().

Let's not do this. I get that using dev_err_probe() even without
possibility of -EPROBE_DEFER is acceptable, but converting
existing drivers is too much IMO. Acceptable < best practice.
