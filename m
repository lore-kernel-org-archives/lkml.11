Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD568C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 12:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbiBQMfC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 07:35:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbiBQMfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:35:01 -0500
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8636429E956
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:34:45 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id CC16C2B0039E;
        Thu, 17 Feb 2022 07:34:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 17 Feb 2022 07:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=yxZqOhBw2SeYA0
        cJinP5U9Ql0aV+14guz7+RfKVsZrA=; b=XaAj9u9nenf/hebmVeG2v7o5z0HhYI
        irJeryp69aOXocxXYANTxFP5aaVXEGXobUicZpM0SqYCEYys1YT+xuzqtx/nrAp6
        h3kTL+htxr0p3q89xC6sHPl2n82H3wKhANc4p3lwgnRErXGKydDfA3g8/vXVvqLr
        NtdMymK0h35hqaldXgwtZMremGSh/ieKWDQ6420UH/trZCNviH1C/W3XU2mhreGm
        xmJ+QTxZbLhbYSTR79QEh3XiedNGxHQcL6QB937b6zmSnbB+Rb/IsmN8XMcqeMWB
        fXurcHe72XmBhGCuLNKkId0FH+ZhZqDPZkg61g4jaQ4zTj6ywuganJ8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=yxZqOhBw2SeYA0cJinP5U9Ql0aV+14guz7+RfKVsZ
        rA=; b=jq6NQuEktRCaUN9V56pCEL4p/lj3xA/loTUWe8L9rhH/rzaMQ0loHQi2Z
        +uieCHZI6QfU+rZWVrNoEQwxmqv/X4+0/8hk4kBO9TuatDHo2OX0H8r7gYvjHFdS
        mLJvC+d25wcDtXK0FK0+rBKai5D7GaqQ4PpM5qSD0PtSzKXHMe3J2XTd9uRMOk7a
        dZ2Y8W+I1XsUJ9l9xhbstW1mvP9fOJbVjcLQkTEvtiOPO6jbvWc8FpSiEhunTs7E
        fpwYnfsn6Xs/WwCvUhe/qYkuTK9Q9uGDguBPVXiDZLMQu9TQunz0oQO72x6VNyca
        AaCmL8G/LIPtJIxbe/agn2HyHG9kQ==
X-ME-Sender: <xms:4kAOYsNMMRV1XJc6nZpz0VZexcgRj8iteQhdwCwtnW2G3nudQP-PVw>
    <xme:4kAOYi_9rnYesmH0D6IzLhD70uy1LiTQbaE_W5UjNLn9gT6trVGMt0HJhtxsewx-O
    9U9Pq6X-foVcQ>
X-ME-Received: <xmr:4kAOYjRfruB1wmP6tQormnwsw6KPvdEpYFox7633eB0_wdG3u4oo12x52COW_6ErPvcafzZEOwEsvF_K0U_k5lk7oNpjnLzx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtugfgjgesthekre
    dttddtudenucfhrhhomhepfdhgrhgvgheskhhrohgrhhdrtghomhdfuceoghhrvghgsehk
    rhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpedujefhgeejhfffuedvieeuvddtue
    etkefhteelheejffegueduheelfefgkeekkeenucffohhmrghinhepihhnthgvlhdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrh
    gvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:4kAOYkutmnRnV3HUNOCZrzMYaUjfm5RPC-aLqofIq3AR9eE-H-XS8Q>
    <xmx:4kAOYkfv9KR_edZtcS4HdCvmZLikjsgnZRfNxPZgWfDCHLgJJQSUfA>
    <xmx:4kAOYo1HnvNuDhvDc5k3hRa3uxFCDfmt2Vq1IuzihK-ayzzNMfMwxQ>
    <xmx:40AOYntC_uNPbMo-rcTsRfHrLnVFpa0RKa8UH7g0Kk7Gl-WT7fjGJSz19jU>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 07:34:42 -0500 (EST)
Date:   Thu, 17 Feb 2022 13:34:40 +0100
From:   "greg@kroah.com" <greg@kroah.com>
To:     Dmitrii Okunev <xaionaro@fb.com>
Cc:     "pavel@ucw.cz" <pavel@ucw.cz>,
        "qiaowei.ren@intel.com" <qiaowei.ren@intel.com>,
        "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "xiaoyan.zhang@intel.com" <xiaoyan.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "gang.wei@intel.com" <gang.wei@intel.com>,
        Jonathan McDowell <noodles@fb.com>
Subject: Re: [discuss] Improve and merge a driver proposed in 2013: sysfs
 interfaces to access TXT config space
Message-ID: <Yg5A4Mupue0V9diu@kroah.com>
References: <1368465884-14779-1-git-send-email-qiaowei.ren@intel.com>
 <1368465884-14779-3-git-send-email-qiaowei.ren@intel.com>
 <20130516160311.GA12299@amd.pavel.ucw.cz>
 <4febd50da7e5007a2797e0f4c969fa5edd0bf725.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4febd50da7e5007a2797e0f4c969fa5edd0bf725.camel@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 11:47:21AM +0000, Dmitrii Okunev wrote:
> Hello!
> 
> As far as I see the patch wasn't merged. And I see that this is the
> only unsolved thread in the discussion:
> 
> On Thu, 2013-05-16 at 18:03 +0200, Pavel Machek wrote:
> > On Tue 2013-05-14 01:24:43, Qiaowei Ren wrote:
> > > These interfaces are located in
> > > /sys/devices/platform/intel_txt/config,
> > > and including totally 37 files, providing access to Intel TXT
> > > configuration registers.
> > 
> > This looks like very wrong interface... equivalent of /dev/mem.
> 
> As an active user of these registers I hope it will be merged, so I
> would like to improve this patch (or rewrite it from scratch) to make
> that happen. Otherwise one have to do hackery around `/dev/mem`, which
> also creates problems with proper access control.
> 
> To be able to improve the patch, could somebody clarify why exactly
> this is a "very wrong interface"?
> 
> > > +What:          /sys/devices/platform/intel_txt/config/STS_raw
> > > +Date:          May 2013
> > > +KernelVersion: 3.9
> > > +Contact:       "Qiaowei Ren" <qiaowei.ren@intel.com>
> > > +Description:   TXT.STS is the general status register. This read-
> > > only register
> > > +               is used by AC modules and the MLE to get the status
> > > of various
> > > +               Intel TXT features.
> > 
> > This is not enough to allow people to understand what this
> > does/should
> > do, nor does it allow (for example) ARM people to implement something
> > compatible.
> > 
> > Is there specific reason why "better" interface is impossible?
> 
> I would love to reuse Intel's public documentation [1] to provide a
> proper description (with bit layout of the value).
> 
> [1] https://cdrdv2.intel.com/v1/dl/getContent/315168
> 
> > [...], nor does it allow (for example) ARM people to
> > implement something compatible.
> 
> Do I understand correctly that a proper documentation of the registers
> solves the problem?
> 
> > Is there specific reason why "better" interface is impossible?
> 
> What are specific problems with the current interface?

What do you mean by "current" here?  You are referring to an email from
2013, 9 years ago.

If you want to propose the change again, correctly update the patch and
submit it that way.

thanks,

greg k-h
