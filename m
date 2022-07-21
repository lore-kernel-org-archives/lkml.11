Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4039C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 13:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiGUNut (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiGUNu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:50:28 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A1434CE38
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:50:23 -0700 (PDT)
Received: (qmail 230363 invoked by uid 1000); 21 Jul 2022 09:50:23 -0400
Date:   Thu, 21 Jul 2022 09:50:23 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Cc:     gregkh@linuxfoundation.org, kishon@ti.com, dianders@chromium.org,
        s.shtylyov@omp.ru, mka@chromium.org, ming.lei@canonical.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        tonywwang@zhaoxin.com, weitaowang@zhaoxin.com,
        CobeChen@zhaoxin.com, TimGuo@zhaoxin.com
Subject: Re: [PATCH] USB: HCD: Fix URB giveback issue in tasklet function
Message-ID: <YtlZn74MDEj+1On9@rowland.harvard.edu>
References: <20220721060833.4173-1-WeitaoWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721060833.4173-1-WeitaoWang-oc@zhaoxin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 02:08:33PM +0800, Weitao Wang wrote:
> Usb core introduce the mechanism of giveback of URB in tasklet context to
> reduce hardware interrupt handling time. On some test situation(such as
> FIO with 4KB block size), when tasklet callback function called to
> giveback URB, interrupt handler add URB node to the bh->head list also.
> If check bh->head list again after finish all URB giveback of local_list,
> then it may introduce a "dynamic balance" between giveback URB and add URB
> to bh->head list. This tasklet callback function may not exit for a long
> time, which will cause other tasklet function calls to be delayed. Some
> real-time applications(such as KB and Mouse) will see noticeable lag.
> 
> Fix this issue by taking new URBs giveback in next tasklet function call.

The patch also replaces the local high_prio_bh variable with a new
bh->high_prio structure member.  This should be mentioned in the patch 
description.

Alan Stern
