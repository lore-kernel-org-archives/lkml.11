Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387F3C00140
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Aug 2022 08:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiHBIUF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Aug 2022 04:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbiHBIUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:20:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E594532EC3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 891E9B819D0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA7AC433C1;
        Tue,  2 Aug 2022 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659428399;
        bh=XgwKA0mkCkCTsNw2LXbYMe8gfREdShiCQyRYibvV+2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j5cqY8jGaqhQxYFED+XpMKLpcM3iONjwHsx4+2n7Q/asEWFyA4tgmXWKG8j5dDfAn
         kaqv4IwWn09HAqQzu4mIQNlQwjTuPrjVVWOkHey+Xlmm593MWO7bSysG2cfRLbd8BD
         J/1sIxnuGxsWm6fxOIAAeM8dTZeL6w4vA0B4V2T0=
Date:   Tue, 2 Aug 2022 10:19:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] staging: greybus:using the
 pm_runtime_resume_and_get  to simplify the code
Message-ID: <YujeLEMsIrVD2tGn@kroah.com>
References: <20220802074542.1648594-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802074542.1648594-1-ye.xingchen@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 07:45:42AM +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
> and pm_runtime_put_noidle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Please follow the rules in
Documentation/process/researcher-guidelines.rst for stuff like this,
otherwise I have to reject it.

greg k-h
