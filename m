Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2744CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 18:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349205AbiDKSlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 14:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349199AbiDKSlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:41:42 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EB027B21
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 11:39:26 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1ndywY-0008Nb-GI; Mon, 11 Apr 2022 20:39:18 +0200
Date:   Mon, 11 Apr 2022 20:39:18 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] staging: r8188eu: don't set _SUCCESS again
Message-ID: <20220411183918.4mw5x6tatslii7mg@viti.kaiser.cx>
References: <20220409151557.207980-1-martin@kaiser.cx>
 <20220409151557.207980-3-martin@kaiser.cx>
 <20220411101834.GW3293@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411101834.GW3293@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Dan Carpenter (dan.carpenter@oracle.com):

> On Sat, Apr 09, 2022 at 05:15:51PM +0200, Martin Kaiser wrote:
> > ret is initialized to _SUCCESS, there's no need to set it again.

> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>

> I liked the original code better.  Otherwise you wonder, is it
> intentional to return success on this path. 

You're right. The original code is easier to understand. It's not
obvious that this check should return _SUCCESS and the remaining ones
return _FAIL.

Greg, could you drop this patch or should I resend the series without
this patch?

Thanks,
Martin
