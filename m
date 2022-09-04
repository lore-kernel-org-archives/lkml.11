Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87932C54EE9
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Sep 2022 01:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiIDBAM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Sep 2022 21:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIDBAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 21:00:08 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FD133A25
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 18:00:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9798B3200893;
        Sat,  3 Sep 2022 21:00:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 03 Sep 2022 21:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1662253204; x=1662339604; bh=ys
        aNHb7Uv24j5dgc8CSczy1swMnmBB99rbQQC8/AlhM=; b=SxFAOsDw6SXneDJiyk
        aHmPxH2/rk2dyBpq0Ui1i1RlvcWvT/Kyh3wSO8YVWdl9+BIgmtjdqeWQc7X3z1eW
        X7GqBC2+so91eAALKAz2ZPutuxJQocoOhKRHY65NTd+nU6Ke53yTX3CJlQv+feBg
        50E7bwK/LX0OvlOQGWt0XHFSsKdFhZYqi7ZMo0OTv/kDXPb8uzkAnv7JlGPvjugd
        Yq5NIOZnnyz6XVKpwfbsIZObBjjnHPuoz7VwsmExKXmtWWa0xO8/u3Z4pa5Kf7Jq
        4VrMUaqJa/UdPO3JZxWtNVUdAlphNr2BTjVnnipRVX8ExsfolbZ3CMyO7Nvf3QT8
        UM/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662253204; x=1662339604; bh=ysaNHb7Uv24j5dgc8CSczy1swMnm
        BB99rbQQC8/AlhM=; b=JEasy3jiryWnFKh+MMbftee9Ia3w6eWcXyVs8dadqYQj
        4i6zVIMkpA980JOFD+fnaN7w1ozxk8hLZzX/N85tp5L14BMCS1MdaiJYEyJKzzZx
        crOz8YAwSZi2zEoiEoutO1zTXTiAvGC8uFczaMIL/jbDKdspR+HvPqy5kUbJm1HB
        retb726SZkjWW1l5paud1R0158JRUWvLQbeEourGWIT4PcOwuIPtRcUMmuBbGfiF
        qpEp79hTQRKLJBRxm6BFOkiTxUAwz/XnKdxZCldkg/j0JrZvK+xv+qm5l2smNm7D
        xWUcxcaSmft/lxBf/9iz6VuqqNnofWXuEO1tVjCOsA==
X-ME-Sender: <xms:k_gTY1RfT3ky1EKYshaw9zyFAls0wQxaWwCihIeWrqyF-d7T7As_2Q>
    <xme:k_gTY-wq1_dTGIKwNdsBYFCEDsVyE486kqj0K94WH_lEsgVCXPb9oqmJ_vSimsDko
    XqxNHTKHcTlZlUYUh8>
X-ME-Received: <xmr:k_gTY62mHQgJHzmgc8xL_5mvedtiPMfnVbgkYmZxrwoUp-QDl_Ofg5oQALZRijTAOvsQbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelfedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeelgffhfeetlefhveffleevfffgtefffeelfedu
    udfhjeduteeggfeiheefteehjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:k_gTY9DRvgqYiQ97xDvJiTALLPq36a9-5SrUA8Jgqw1oLDLuMSKB0w>
    <xmx:k_gTY-j5wwt0m_HI51S2N5oL7qQJxAbc4f2S6AWVibg1jRRxCBF0dQ>
    <xmx:k_gTYxp0vif6KoYw56Mdklmy4uOTlLLFvb927dW6iONBgem13lxkYQ>
    <xmx:lPgTY1Q4nlz8n5JQOl2jjk4FQz_DPvyudl4BoWYamyoKEc8_iCuhGg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Sep 2022 21:00:03 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8162D104A03; Sun,  4 Sep 2022 04:00:01 +0300 (+03)
Date:   Sun, 4 Sep 2022 04:00:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Bharata B Rao <bharata@amd.com>, ananth.narayan@amd.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220904010001.knlcejmw4lg2uzy3@box.shutemov.name>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 04:00:53AM +0300, Kirill A. Shutemov wrote:
> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> 64-bit linear addresses, allowing software to use of the untranslated
> address bits for metadata.
> 
> The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
> this time.
> 
> Please review and consider applying.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam

+Bharata, Ananth.

Do you folks have any feedback on the patchset?

Looks like AMD version of the tagged pointers feature does not get
traction as of now, but I want to be sure that the interface introduced
here can be suitable for your future plans.

Do you see anything in the interface that can prevent it to be extended to
the AMD feature?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
