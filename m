Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 06:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiDYGpO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 02:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiDYGpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:45:10 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9648C28E0D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:42:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2984B80FA;
        Mon, 25 Apr 2022 06:39:07 +0000 (UTC)
Date:   Mon, 25 Apr 2022 09:42:05 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     cgel.zte@gmail.com, ssantosh@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] soc: ti: pm33xx: using pm_runtime_resume_and_get instead
 of pm_runtime_get_sync
Message-ID: <YmZCvYEK0LVWmPsh@atomide.com>
References: <20220418063059.2558074-1-chi.minghao@zte.com.cn>
 <20220422184021.v2w55kbvllu3flar@daughter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422184021.v2w55kbvllu3flar@daughter>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [220422 18:37]:
> On 06:30-20220418, cgel.zte@gmail.com wrote:
> > From: Minghao Chi <chi.minghao@zte.com.cn>
> > 
> > Using pm_runtime_resume_and_get is more appropriate
> > for simplifing code
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Tony: Could you check?

Looks good to me:

Reviewed-by: Tony Lindgren <tony@aotmide.com>
