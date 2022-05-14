Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2208DC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 May 2022 17:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiENRyz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 May 2022 13:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiENRyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 13:54:50 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F582EA15
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 10:54:48 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 90D7412094E;
        Sat, 14 May 2022 17:54:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 2F51D2D;
        Sat, 14 May 2022 17:54:46 +0000 (UTC)
Message-ID: <b69cd7d3f0e3b62c5ef12cd1b98eac45f56022a4.camel@perches.com>
Subject: Re: [PATCH 4/7] staging: r8188eu: replace if with ternary operator
From:   Joe Perches <joe@perches.com>
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sat, 14 May 2022 10:54:45 -0700
In-Reply-To: <20220514164740.282552-5-martin@kaiser.cx>
References: <20220514164740.282552-1-martin@kaiser.cx>
         <20220514164740.282552-5-martin@kaiser.cx>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: of6njk9kz39zwsw47omzsej8oneyxy4w
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 2F51D2D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/9dge58uXWeAVx2Yd3Zdw4G+hZcBv5j64=
X-HE-Tag: 1652550886-835860
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-05-14 at 18:47 +0200, Martin Kaiser wrote:
> Replace an if statement with a ternary operator, making the code a tiny
> bit shorter.
[]
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
[]
> @@ -1503,10 +1503,8 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
>  		preorder_ctrl->indicate_seq = 0xffff;
>  		preorder_ctrl->enable = pmlmeinfo->bAcceptAddbaReq;
>  
> -		if (pmlmeinfo->bAcceptAddbaReq)
> -			issue_action_BA(padapter, mgmt->sa, WLAN_ACTION_ADDBA_RESP, 0);
> -		else
> -			issue_action_BA(padapter, mgmt->sa, WLAN_ACTION_ADDBA_RESP, 37);/* reject ADDBA Req */
> +		issue_action_BA(padapter, mgmt->sa, WLAN_ACTION_ADDBA_RESP,
> +				pmlmeinfo->bAcceptAddbaReq ? 0 : 37);

Seems like magic numbers.  Maybe add/use defines?


