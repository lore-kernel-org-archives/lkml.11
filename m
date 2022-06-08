Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12B2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 03:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiFHDHk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 23:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353786AbiFHDBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:01:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70D01D64FC;
        Tue,  7 Jun 2022 17:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBE766164B;
        Wed,  8 Jun 2022 00:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A23FC34114;
        Wed,  8 Jun 2022 00:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654648093;
        bh=XboHJuRyj/Glo0PwahxOUll/k5bf6FTay0X08dtiOi4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dQyluGwXqwdjFDgfqmfl3lRH5Y99+gwlU/Dz0WmqBBtFJXHKr2Wr3Y9i5kOs8fOiF
         yFnpieRFONzgLTz+RC4GD4U81AtfJOspz9wOCQmTQpxqNKMswiPbg2p3QtqCCHPZ1+
         0e+RYd/cIHxJmFqJjptIg4z+2nLVldbECkMBDkmm2kQDU0m6k0cV8qMeP6+ANvfyqZ
         sAKrcNxYM04wKGvqQXGzSKze2SMicWtg8muGNfwKRHY+pyTr9eOYjXzSQpQzk2Jo6C
         JJGIGcboRBhEZQWIRwUhEKKzbeVjjYyAwyQ3bzqVyCin2p0Q8F3de8C29AuPJ+U4gc
         ZlwbemVy5EJDg==
Date:   Tue, 7 Jun 2022 17:28:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ronak Doshi <doshir@vmware.com>
Cc:     <netdev@vger.kernel.org>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 5/8] vmxnet3: add command to set ring buffer
 sizes
Message-ID: <20220607172812.489814b9@kernel.org>
In-Reply-To: <20220607084518.30316-6-doshir@vmware.com>
References: <20220607084518.30316-1-doshir@vmware.com>
        <20220607084518.30316-6-doshir@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 01:45:15 -0700 Ronak Doshi wrote:
> +		adapter->ringBufSize.ring1BufSizeType0 = adapter->skb_buf_size;
> +		adapter->ringBufSize.ring1BufSizeType1 = 0;
> +		adapter->ringBufSize.ring2BufSizeType1 = PAGE_SIZE;

These need to use correct byte ordering helpers, since the fields are
__le16 probably cpu_to_le16().
